const API_BASE = import.meta.env.VITE_API_BASE ?? '';

type FetchOptions = RequestInit & {
  skipJson?: boolean;
};

export async function apiFetch<T>(path: string, options: FetchOptions = {}): Promise<T> {
  const headers = new Headers(options.headers ?? {});
  const isForm = options.body instanceof FormData;
  if (!isForm && !headers.has('Content-Type')) {
    headers.set('Content-Type', 'application/json');
  }

  const response = await fetch(`${API_BASE}${path}`, {
    credentials: 'include',
    ...options,
    headers,
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(text || response.statusText);
  }

  if (options.skipJson || response.status === 204) {
    return undefined as T;
  }

  const contentType = response.headers.get('content-type');
  if (contentType && contentType.includes('application/json')) {
    return (await response.json()) as T;
  }

  return (await response.text()) as unknown as T;
}

export function buildUrl(path: string, params?: Record<string, string | number | undefined | null>) {
  const url = new URL(`${API_BASE}${path}`, window.location.origin);
  if (params) {
    Object.entries(params).forEach(([key, value]) => {
      if (value !== undefined && value !== null && value !== '') {
        url.searchParams.append(key, String(value));
      }
    });
  }
  return url.pathname + url.search;
}
