namespace WebDungCuLamBanh.Services;

public class OperationResult<T>
{
    public bool Success { get; }
    public string? ErrorMessage { get; }
    public T? Data { get; }

    private OperationResult(bool success, T? data, string? errorMessage)
    {
        Success = success;
        Data = data;
        ErrorMessage = errorMessage;
    }

    public static OperationResult<T> Ok(T data) => new(true, data, null);
    public static OperationResult<T> Fail(string message) => new(false, default, message);
    public static OperationResult<T> SuccessResult(T data) => new(true, data, null);
    public static OperationResult<T> FailureResult(string message) => new(false, default, message);
}

public class OperationResult
{
    public bool Success { get; }
    public string? ErrorMessage { get; }

    private OperationResult(bool success, string? errorMessage)
    {
        Success = success;
        ErrorMessage = errorMessage;
    }

    public static OperationResult Ok() => new(true, null);
    public static OperationResult Fail(string message) => new(false, message);
    public static OperationResult SuccessResult() => new(true, null);
    public static OperationResult FailureResult(string message) => new(false, message);
}
