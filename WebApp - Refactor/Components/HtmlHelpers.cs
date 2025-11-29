using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Globalization;
namespace WebDungCuLamBanh.Helpers
{
    public static class HtmlHelpers
    {
        public static IHtmlContent FormatCurrency(this IHtmlHelper html, decimal amount)
        {
            NumberFormatInfo nfi = new CultureInfo("vi-VN", false).NumberFormat;
            nfi.NumberGroupSeparator = ".";
            nfi.NumberDecimalDigits = 0;

            string formattedValue = amount.ToString("N", nfi) + " ₫";
            return new HtmlString(formattedValue);
        }
        public static string FormatCurrency(decimal amount)
        {
            NumberFormatInfo nfi = new CultureInfo("vi-VN", false).NumberFormat;
            nfi.NumberGroupSeparator = ".";
            nfi.NumberDecimalDigits = 0;

            string formattedValue = amount.ToString("N", nfi) + " ₫";
            return formattedValue;
        }
        public static IHtmlContent FormatTime(this IHtmlHelper html, DateTime time)
        {
            
            string formattedValue = time.ToString("HH:mm dd.MM.yyyy ");
            return new HtmlString(formattedValue);
        }
    }
}
