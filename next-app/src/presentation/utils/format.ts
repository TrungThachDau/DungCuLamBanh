export function formatCurrency(amount: number): string {
  return new Intl.NumberFormat("vi-VN").format(amount) + "₫";
}

export function calcDiscountPercent(original: number, discounted: number | null): number {
  if (!discounted || discounted <= 0 || original <= 0) return 0;
  return Math.round(((original - discounted) / original) * 100);
}
