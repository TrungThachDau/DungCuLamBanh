export function formatCurrency(amount: number): string {
  return new Intl.NumberFormat("vi-VN").format(amount) + "₫";
}

export function getImageUrl(path: string | null | undefined): string {
  if (!path) return "/placeholder.png";
  if (path.startsWith("http")) return path;
  const base = process.env.NEXT_PUBLIC_API_URL || "http://localhost:5000";
  return `${base}${path.startsWith("/") ? "" : "/"}${path}`;
}

export function calcDiscountPercent(original: number, discounted: number | null): number {
  if (!discounted || discounted <= 0 || original <= 0) return 0;
  return Math.round(((original - discounted) / original) * 100);
}
