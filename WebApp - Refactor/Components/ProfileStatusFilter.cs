using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
namespace WebDungCuLamBanh.Components
{
    public class ProfileStatusFilter: ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            var controller = context.Controller as Controller;
            if (controller != null)
            {
                // Giả sử bạn lấy email từ HttpContext hoặc dịch vụ của bạn
                var email = context.HttpContext.Session.GetString("email");
                var uid = context.HttpContext.Session.GetString("uid");
                var spvuaxem = context.HttpContext.Session.GetString("idspvuaxem");
                controller.ViewBag.email = email;
                controller.ViewBag.uid = uid;
                controller.ViewBag.idspvuaxem = spvuaxem;
            }
            base.OnActionExecuting(context);
        }
    }
}
