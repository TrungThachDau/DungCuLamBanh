namespace WebDungCuLamBanh.Services
{
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
    }
}
