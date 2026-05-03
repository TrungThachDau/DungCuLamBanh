export function getImageUrl(path: string | null | undefined): string {
  if (!path) return "/placeholder.png";
  if (path.startsWith("http")) return path;
  const base = process.env.NEXT_PUBLIC_API_URL || "http://localhost:5000";
  return `${base}${path.startsWith("/") ? "" : "/"}${path}`;
}
