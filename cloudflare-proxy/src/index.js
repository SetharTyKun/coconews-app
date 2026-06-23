const GNEWS_BASE_URL = "https://gnews.io/api/v4/top-headlines";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
};

export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    const url = new URL(request.url);
    const category = url.searchParams.get("category") || "general";
    const country = url.searchParams.get("country") || "us";
    const lang = url.searchParams.get("lang") || "en";

    const gnewsUrl =
      `${GNEWS_BASE_URL}?category=${encodeURIComponent(category)}` +
      `&country=${encodeURIComponent(country)}` +
      `&lang=${encodeURIComponent(lang)}` +
      `&apikey=${env.NEWS_API_KEY}`;

    try {
      const gnewsResponse = await fetch(gnewsUrl);
      const data = await gnewsResponse.text();

      return new Response(data, {
        status: gnewsResponse.status,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    } catch (err) {
      return new Response(JSON.stringify({ error: "Failed to fetch news" }), {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
  },
};
