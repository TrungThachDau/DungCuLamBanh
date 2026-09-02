using System.ComponentModel.DataAnnotations;

namespace WebDungCuLamBanh.DTOs.Auth;

public class LoginRequestDto
{
    [Required(ErrorMessage = "Email hoặc tên người dùng là bắt buộc")]
    public string EmailOrUsername { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu là bắt buộc")]
    public string Password { get; set; } = string.Empty;
}

public class AdminLoginDto
{
    [Required(ErrorMessage = "Tên người dùng là bắt buộc")]
    public string TenNguoiDung { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu là bắt buộc")]
    public string MatKhau { get; set; } = string.Empty;
}

public class RegisterRequestDto
{
    [Required(ErrorMessage = "Email là bắt buộc")]
    [EmailAddress(ErrorMessage = "Email không hợp lệ")]
    public string Email { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu là bắt buộc")]
    [MinLength(6, ErrorMessage = "Mật khẩu tối thiểu 6 ký tự")]
    public string Password { get; set; } = string.Empty;

    [Required(ErrorMessage = "Tên là bắt buộc")]
    public string Ten { get; set; } = string.Empty;

    public string? SoDienThoai { get; set; }
    public string? DiaChi { get; set; }
}

public class LoginResponseDto
{
    public string Token { get; set; } = string.Empty;
    public DateTime Expires { get; set; }
    public string Username { get; set; } = string.Empty;
    public string? Email { get; set; }
    public string? Role { get; set; }
}
