import { useEffect, useMemo, useState } from 'react';
import type { FormEvent } from 'react';
import { apiFetch, buildUrl } from './api';
import type {
  AdminModel,
  Category,
  DashboardPayload,
  Manufactor,
  OrderSummary,
  Product,
  Supplier,
  Voucher,
} from './types';

type Tab = 'login' | 'dashboard' | 'products' | 'orders' | 'vouchers' | 'goods';

const tabs: { id: Tab; label: string }[] = [
  { id: 'login', label: 'Đăng nhập' },
  { id: 'dashboard', label: 'Dashboard' },
  { id: 'products', label: 'Sản phẩm' },
  { id: 'orders', label: 'Đơn hàng' },
  { id: 'vouchers', label: 'Voucher' },
  { id: 'goods', label: 'Nhập hàng' },
];

function App() {
  const [activeTab, setActiveTab] = useState<Tab>('dashboard');
  const [status, setStatus] = useState<string>('');

  return (
    <div className="container py-4">
      <header className="d-flex flex-column flex-md-row align-items-md-center justify-content-between mb-4">
        <div>
          <div className="fs-4 fw-semibold">Admin SPA</div>
          <div className="text-muted small">
            Vite + React + Bootstrap, kết nối API admin (.NET)
          </div>
        </div>
        <ul className="nav nav-pills mt-3 mt-md-0">
          {tabs.map((tab) => (
            <li className="nav-item" key={tab.id}>
              <button
                className={`nav-link ${activeTab === tab.id ? 'active' : ''}`}
                onClick={() => setActiveTab(tab.id)}
              >
                {tab.label}
              </button>
            </li>
          ))}
        </ul>
      </header>

      {status && (
        <div className="alert alert-info alert-dismissible fade show" role="alert">
          {status}
          <button type="button" className="btn-close" onClick={() => setStatus('')} />
        </div>
      )}

      <div className="row g-4">
        {activeTab === 'login' && <LoginSection onStatus={setStatus} />}
        {activeTab === 'dashboard' && <DashboardSection onStatus={setStatus} />}
        {activeTab === 'products' && <ProductSection onStatus={setStatus} />}
        {activeTab === 'orders' && <OrdersSection onStatus={setStatus} />}
        {activeTab === 'vouchers' && <VoucherSection onStatus={setStatus} />}
        {activeTab === 'goods' && <GoodsReceiptSection onStatus={setStatus} />}
      </div>
    </div>
  );
}

function LoginSection({ onStatus }: { onStatus: (s: string) => void }) {
  const [user, setUser] = useState('admin');
  const [pass, setPass] = useState('');
  const [loading, setLoading] = useState(false);

  const submit = async (e: FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await apiFetch<AdminModel>('/api/admin/AdministratorApi/login', {
        method: 'POST',
        body: JSON.stringify({ tenNguoiDung: user, matKhau: pass }),
      });
      onStatus('Đăng nhập thành công. Cookies session đã được lưu.');
    } catch (err: any) {
      onStatus(`Đăng nhập lỗi: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="col-12">
      <div className="card card-shadow">
        <div className="card-body">
          <div className="d-flex align-items-center gap-2 mb-3">
            <span className="badge text-bg-primary">Session API</span>
            <h5 className="mb-0">Đăng nhập Admin</h5>
          </div>
          <form className="row g-3" onSubmit={submit}>
            <div className="col-md-4">
              <label className="form-label">Tên đăng nhập</label>
              <input
                className="form-control"
                value={user}
                onChange={(e) => setUser(e.target.value)}
                required
              />
            </div>
            <div className="col-md-4">
              <label className="form-label">Mật khẩu</label>
              <input
                className="form-control"
                type="password"
                value={pass}
                onChange={(e) => setPass(e.target.value)}
                required
              />
            </div>
            <div className="col-md-4 d-flex align-items-end">
              <button className="btn btn-primary" type="submit" disabled={loading}>
                {loading ? 'Đang gửi...' : 'Đăng nhập'}
              </button>
            </div>
          </form>
          <p className="mt-3 text-muted small">
            API: <code>/api/admin/AdministratorApi/login</code> (giữ cookie để gọi tiếp các API
            khác).
          </p>
        </div>
      </div>
    </div>
  );
}

function DashboardSection({ onStatus }: { onStatus: (s: string) => void }) {
  const today = useMemo(() => new Date().toISOString().slice(0, 10), []);
  const monthStart = useMemo(() => {
    const d = new Date();
    d.setDate(1);
    return d.toISOString().slice(0, 10);
  }, []);
  const [from, setFrom] = useState(monthStart);
  const [to, setTo] = useState(today);
  const [data, setData] = useState<DashboardPayload | null>(null);
  const [loading, setLoading] = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const res = await apiFetch<DashboardPayload>(
        buildUrl('/api/admin/AdministratorApi/dashboard', { fromDate: from, toDate: to }),
      );
      setData(res);
    } catch (err: any) {
      onStatus(`Dashboard lỗi: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="col-12">
      <div className="card card-shadow">
        <div className="card-body">
          <div className="d-flex flex-wrap align-items-center justify-content-between">
            <div className="d-flex align-items-center gap-2 mb-3">
              <span className="badge text-bg-success">Báo cáo</span>
              <h5 className="mb-0">Dashboard doanh thu</h5>
            </div>
            <form className="d-flex gap-2 flex-wrap" onSubmit={(e) => e.preventDefault()}>
              <input type="date" className="form-control" value={from} onChange={(e) => setFrom(e.target.value)} />
              <input type="date" className="form-control" value={to} onChange={(e) => setTo(e.target.value)} />
              <button className="btn btn-outline-primary" type="button" onClick={load} disabled={loading}>
                {loading ? 'Đang tải...' : 'Lọc'}
              </button>
            </form>
          </div>

          {data && data.summary ? (
            <>
              <div className="row row-cols-1 row-cols-md-3 g-3 mt-2">
                <MetricCard title="Doanh thu tháng" value={data.summary.doanhThuThangNay} />
                <MetricCard title="Lợi nhuận tháng" value={data.summary.loiNhuanThangNay} />
                <MetricCard title="VAT tháng" value={data.summary.vatThangNay} />
                <MetricCard title="Doanh thu lọc" value={data.filter.doanhThuLoc} />
                <MetricCard title="Lợi nhuận lọc" value={data.filter.tienLoiLoc} />
                <MetricCard title="VAT lọc" value={data.filter.vatLoc} />
                <MetricCard title="Doanh thu hôm nay" value={data.today.doanhThuHomNay} />
                <MetricCard title="Lợi nhuận hôm nay" value={data.today.tienLoiHomNay} />
                <MetricCard title="Ship hôm nay" value={data.today.tienShipHomNay} />
              </div>
              <div className="mt-4">
                <h6 className="fw-semibold mb-3">Top sản phẩm tháng</h6>
                <div className="table-responsive">
                  <table className="table table-sm align-middle">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Tên</th>
                        <th>Đã bán</th>
                      </tr>
                    </thead>
                    <tbody>
                      {data.topProducts.map((p, idx) => (
                        <tr key={p.id_DungCu}>
                          <td>{idx + 1}</td>
                          <td>{p.tenSanPham}</td>
                          <td>{p.soLuongBanDuoc}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </>
          ) : (
            <div className="text-muted">Chưa có dữ liệu. Hãy bấm Lọc.</div>
          )}
        </div>
      </div>
    </div>
  );
}

function MetricCard({ title, value }: { title: string; value: number }) {
  return (
    <div className="col">
      <div className="p-3 border rounded-3 bg-white h-100">
        <div className="text-muted small">{title}</div>
        <div className="fs-5 fw-semibold">{formatCurrency(value)}</div>
      </div>
    </div>
  );
}

function ProductSection({ onStatus }: { onStatus: (s: string) => void }) {
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(false);
  const [products, setProducts] = useState<Product[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);
  const [manufactors, setManufactors] = useState<Manufactor[]>([]);
  const [newProduct, setNewProduct] = useState({
    tenDungCu: '',
    gia: '',
    giaNhap: '',
    moTa: '',
    id_LoaiDungCu: '',
    id_NhaCungCap: '',
    id_NhaSanXuat: '',
  });
  const [image, setImage] = useState<File | null>(null);

  const loadLists = async () => {
    try {
      const [cats, sups, mans] = await Promise.all([
        apiFetch<Category[]>('/api/admin/AdministratorApi/categories'),
        apiFetch<Supplier[]>('/api/admin/SupplierApi'),
        apiFetch<Manufactor[]>('/api/admin/ManufactorApi'),
      ]);
      setCategories(cats);
      setSuppliers(sups);
      setManufactors(mans);
    } catch (err: any) {
      onStatus(`Tải danh mục lỗi: ${err.message}`);
    }
  };

  const loadProducts = async () => {
    setLoading(true);
    try {
      const data = await apiFetch<Product[]>(
        buildUrl('/api/admin/AdministratorApi/products', { search }),
      );
      setProducts(
        data.map((p) => ({
          ...p,
          tenDungCu: (p as any).tenDungCu ?? (p as any).tenDungcu ?? '',
        })),
      );
    } catch (err: any) {
      onStatus(`Tải sản phẩm lỗi: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadLists();
    loadProducts();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const submitNewProduct = async (e: FormEvent) => {
    e.preventDefault();
    const form = new FormData();
    form.append('TenDungCu', newProduct.tenDungCu);
    form.append('Gia', newProduct.gia);
    if (newProduct.giaNhap) form.append('GiaNhap', newProduct.giaNhap);
    if (newProduct.moTa) form.append('MoTa', newProduct.moTa);
    if (newProduct.id_LoaiDungCu) form.append('Id_LoaiDungCu', newProduct.id_LoaiDungCu);
    if (newProduct.id_NhaCungCap) form.append('Id_NhaCungCap', newProduct.id_NhaCungCap);
    if (newProduct.id_NhaSanXuat) form.append('Id_NhaSanXuat', newProduct.id_NhaSanXuat);
    if (image) form.append('imageInput', image);

    try {
      await apiFetch('/api/admin/AdministratorApi/products', {
        method: 'POST',
        body: form,
      });
      onStatus('Đã tạo sản phẩm mới');
      setNewProduct({
        tenDungCu: '',
        gia: '',
        giaNhap: '',
        moTa: '',
        id_LoaiDungCu: '',
        id_NhaCungCap: '',
        id_NhaSanXuat: '',
      });
      setImage(null);
      await loadProducts();
    } catch (err: any) {
      onStatus(`Tạo sản phẩm lỗi: ${err.message}`);
    }
  };

  return (
    <div className="col-12">
      <div className="card card-shadow">
        <div className="card-body">
          <div className="d-flex flex-wrap align-items-center justify-content-between gap-2">
            <div className="d-flex align-items-center gap-2">
              <span className="badge text-bg-primary">Sản phẩm</span>
              <h5 className="mb-0">Danh sách</h5>
            </div>
            <div className="d-flex gap-2">
              <input
                className="form-control"
                placeholder="Tìm tên sản phẩm"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
              <button className="btn btn-outline-primary" onClick={loadProducts} disabled={loading}>
                {loading ? 'Đang tải...' : 'Tải'}
              </button>
            </div>
          </div>

          <div className="table-responsive mt-3">
            <table className="table table-hover align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Tên</th>
                  <th>Giá</th>
                  <th>KM</th>
                  <th>SL</th>
                </tr>
              </thead>
              <tbody>
                {products.map((p) => (
                  <tr key={p.id_DungCu}>
                    <td>{p.id_DungCu}</td>
                    <td>{p.tenDungCu}</td>
                    <td>{formatCurrency(p.gia ?? 0)}</td>
                    <td>{p.giaKhuyenMai ? formatCurrency(p.giaKhuyenMai) : '-'}</td>
                    <td>{p.soLuong ?? 0}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <hr className="my-4" />
          <h6 className="fw-semibold mb-3">Tạo sản phẩm</h6>
          <form className="row g-3" onSubmit={submitNewProduct}>
            <div className="col-md-4">
              <label className="form-label">Tên sản phẩm</label>
              <input
                className="form-control"
                value={newProduct.tenDungCu}
                onChange={(e) => setNewProduct((p) => ({ ...p, tenDungCu: e.target.value }))}
                required
              />
            </div>
            <div className="col-md-2">
              <label className="form-label">Giá bán</label>
              <input
                className="form-control"
                type="number"
                min={0}
                value={newProduct.gia}
                onChange={(e) => setNewProduct((p) => ({ ...p, gia: e.target.value }))}
                required
              />
            </div>
            <div className="col-md-2">
              <label className="form-label">Giá nhập</label>
              <input
                className="form-control"
                type="number"
                min={0}
                value={newProduct.giaNhap}
                onChange={(e) => setNewProduct((p) => ({ ...p, giaNhap: e.target.value }))}
              />
            </div>
            <div className="col-md-4">
              <label className="form-label">Mô tả</label>
              <input
                className="form-control"
                value={newProduct.moTa}
                onChange={(e) => setNewProduct((p) => ({ ...p, moTa: e.target.value }))}
              />
            </div>
            <div className="col-md-4">
              <label className="form-label">Loại dụng cụ</label>
              <select
                className="form-select"
                value={newProduct.id_LoaiDungCu}
                onChange={(e) => setNewProduct((p) => ({ ...p, id_LoaiDungCu: e.target.value }))}
              >
                <option value="">Chọn loại</option>
                {categories.map((c) => (
                  <option key={c.id_LoaiDungCu} value={c.id_LoaiDungCu}>
                    {c.tenLoaiDungCu}
                  </option>
                ))}
              </select>
            </div>
            <div className="col-md-4">
              <label className="form-label">Nhà cung cấp</label>
              <select
                className="form-select"
                value={newProduct.id_NhaCungCap}
                onChange={(e) => setNewProduct((p) => ({ ...p, id_NhaCungCap: e.target.value }))}
              >
                <option value="">Chọn NCC</option>
                {suppliers.map((s) => (
                  <option key={s.id_NhaCungCap} value={s.id_NhaCungCap}>
                    {s.tenNhaCungCap}
                  </option>
                ))}
              </select>
            </div>
            <div className="col-md-4">
              <label className="form-label">Nhà sản xuất</label>
              <select
                className="form-select"
                value={newProduct.id_NhaSanXuat}
                onChange={(e) => setNewProduct((p) => ({ ...p, id_NhaSanXuat: e.target.value }))}
              >
                <option value="">Chọn NSX</option>
                {manufactors.map((m) => (
                  <option key={m.id_NhaSanXuat} value={m.id_NhaSanXuat}>
                    {m.tenNSX}
                  </option>
                ))}
              </select>
            </div>
            <div className="col-md-4">
              <label className="form-label">Ảnh (tùy chọn)</label>
              <input
                type="file"
                className="form-control"
                accept="image/*"
                onChange={(e) => setImage(e.target.files?.[0] ?? null)}
              />
            </div>
            <div className="col-12">
              <button className="btn btn-success" type="submit">
                Tạo sản phẩm
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

function OrdersSection({ onStatus }: { onStatus: (s: string) => void }) {
  const [data, setData] = useState<OrderSummary | null>(null);
  const [loading, setLoading] = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const res = await apiFetch<OrderSummary>('/api/admin/AdministratorApi/orders');
      setData(res);
    } catch (err: any) {
      onStatus(`Tải đơn hàng lỗi: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="col-12">
      <div className="card card-shadow">
        <div className="card-body">
          <div className="d-flex align-items-center gap-2 mb-3">
            <span className="badge text-bg-warning">Đơn hàng</span>
            <h5 className="mb-0">Tình trạng vận chuyển</h5>
            <button className="btn btn-outline-primary btn-sm ms-auto" onClick={load} disabled={loading}>
              {loading ? 'Đang tải...' : 'Làm mới'}
            </button>
          </div>
          {data?.stats && (
            <div className="row row-cols-2 row-cols-md-4 g-3 mb-3">
              <MetricCard title="Chờ giao" value={data.stats.choGiao} />
              <MetricCard title="Đang giao" value={data.stats.dangGiao} />
              <MetricCard title="Đã giao" value={data.stats.daGiao} />
              <MetricCard title="Đã hủy" value={data.stats.daHuy} />
            </div>
          )}
          <div className="table-responsive">
            <table className="table table-sm table-hover align-middle">
              <thead>
                <tr>
                  <th>ID VC</th>
                  <th>Đơn hàng</th>
                  <th>Ngày đặt</th>
                  <th>TT VC</th>
                  <th>Tiền</th>
                </tr>
              </thead>
              <tbody>
                {data?.orders?.map((o) => (
                  <tr key={o.id_DHVC}>
                    <td>{o.id_DHVC}</td>
                    <td>{o.donHang?.id_DonHang}</td>
                    <td>{o.donHang?.ngayDat ? new Date(o.donHang.ngayDat).toLocaleDateString() : '-'}</td>
                    <td>{o.trangThaiVanChuyen?.tenTrangThai ?? '-'}</td>
                    <td>{o.donHang?.tongTien ? formatCurrency(o.donHang.tongTien) : '-'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {!data?.orders?.length && <div className="text-muted">Chưa có đơn hàng.</div>}
        </div>
      </div>
    </div>
  );
}

function VoucherSection({ onStatus }: { onStatus: (s: string) => void }) {
  const [vouchers, setVouchers] = useState<Voucher[]>([]);
  const [newVoucher, setNewVoucher] = useState({ id: '', value: 0, moTa: '' });

  const load = async () => {
    try {
      const data = await apiFetch<Voucher[]>('/api/admin/AdministratorApi/vouchers');
      setVouchers(
        data.map((v) => ({
          id_MaGiamGia: (v as any).id_MaGiamGia ?? (v as any).id_MaGiamgia ?? '',
          giaTriGiam: Number((v as any).giaTriGiam ?? 0),
          moTa: (v as any).moTa,
        })),
      );
    } catch (err: any) {
      onStatus(`Tải voucher lỗi: ${err.message}`);
    }
  };

  useEffect(() => {
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const submit = async (e: FormEvent) => {
    e.preventDefault();
    try {
      await apiFetch('/api/admin/AdministratorApi/vouchers', {
        method: 'POST',
        body: JSON.stringify({
          id_MaGiamGia: newVoucher.id,
          giaTriGiam: newVoucher.value,
          moTa: newVoucher.moTa,
        }),
      });
      onStatus('Đã tạo voucher');
      setNewVoucher({ id: '', value: 0, moTa: '' });
      await load();
    } catch (err: any) {
      onStatus(`Tạo voucher lỗi: ${err.message}`);
    }
  };

  return (
    <div className="col-12">
      <div className="card card-shadow">
        <div className="card-body">
          <div className="d-flex align-items-center gap-2 mb-3">
            <span className="badge text-bg-info">Voucher</span>
            <h5 className="mb-0">Danh sách mã giảm giá</h5>
          </div>
          <div className="table-responsive mb-4">
            <table className="table table-hover align-middle">
              <thead>
                <tr>
                  <th>Mã</th>
                  <th>Giá trị (%)</th>
                  <th>Mô tả</th>
                </tr>
              </thead>
              <tbody>
                {vouchers.map((v) => (
                  <tr key={v.id_MaGiamGia}>
                    <td>{v.id_MaGiamGia}</td>
                    <td>{v.giaTriGiam}</td>
                    <td>{v.moTa ?? '-'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            {!vouchers.length && <div className="text-muted">Chưa có voucher.</div>}
          </div>

          <h6 className="fw-semibold mb-3">Tạo voucher</h6>
          <form className="row g-3" onSubmit={submit}>
            <div className="col-md-3">
              <label className="form-label">Mã</label>
              <input
                className="form-control"
                value={newVoucher.id}
                onChange={(e) => setNewVoucher((p) => ({ ...p, id: e.target.value }))}
                required
              />
            </div>
            <div className="col-md-2">
              <label className="form-label">% giảm</label>
              <input
                className="form-control"
                type="number"
                min={1}
                max={99}
                value={newVoucher.value}
                onChange={(e) => setNewVoucher((p) => ({ ...p, value: Number(e.target.value) }))}
                required
              />
            </div>
            <div className="col-md-5">
              <label className="form-label">Mô tả</label>
              <input
                className="form-control"
                value={newVoucher.moTa}
                onChange={(e) => setNewVoucher((p) => ({ ...p, moTa: e.target.value }))}
              />
            </div>
            <div className="col-md-2 d-flex align-items-end">
              <button className="btn btn-success" type="submit">
                Tạo
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

function GoodsReceiptSection({ onStatus }: { onStatus: (s: string) => void }) {
  const [receipts, setReceipts] = useState<any[]>([]);
  const [search, setSearch] = useState('');
  const [newReceipt, setNewReceipt] = useState({ id: '', supplier: '' });
  const [suppliers, setSuppliers] = useState<Supplier[]>([]);

  const load = async () => {
    try {
      const data = await apiFetch<any[]>(
        buildUrl('/api/admin/GoodsReceiptApi', { search }),
      );
      setReceipts(data);
    } catch (err: any) {
      onStatus(`Tải phiếu nhập lỗi: ${err.message}`);
    }
  };

  const loadSuppliers = async () => {
    try {
      const data = await apiFetch<Supplier[]>('/api/admin/SupplierApi');
      setSuppliers(data);
    } catch (err: any) {
      onStatus(`Tải NCC lỗi: ${err.message}`);
    }
  };

  useEffect(() => {
    load();
    loadSuppliers();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const submit = async (e: FormEvent) => {
    e.preventDefault();
    try {
      await apiFetch('/api/admin/GoodsReceiptApi', {
        method: 'POST',
        body: JSON.stringify({
          id_HoaDonNhap: newReceipt.id,
          id_NhaCungCap: newReceipt.supplier ? Number(newReceipt.supplier) : undefined,
        }),
      });
      onStatus('Đã tạo phiếu nhập');
      setNewReceipt({ id: '', supplier: '' });
      await load();
    } catch (err: any) {
      onStatus(`Tạo phiếu nhập lỗi: ${err.message}`);
    }
  };

  return (
    <div className="col-12">
      <div className="card card-shadow">
        <div className="card-body">
          <div className="d-flex align-items-center gap-2 mb-3">
            <span className="badge text-bg-secondary">Nhập hàng</span>
            <h5 className="mb-0">Phiếu nhập</h5>
            <div className="ms-auto d-flex gap-2">
              <input
                className="form-control"
                placeholder="Tìm mã phiếu hoặc NCC"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
              <button className="btn btn-outline-primary" type="button" onClick={load}>
                Lọc
              </button>
            </div>
          </div>
          <div className="table-responsive">
            <table className="table table-sm align-middle">
              <thead>
                <tr>
                  <th>Mã HĐ</th>
                  <th>Nhà cung cấp</th>
                  <th>Ngày lập</th>
                  <th>Trạng thái</th>
                  <th>Tổng tiền</th>
                </tr>
              </thead>
              <tbody>
                {receipts.map((r) => (
                  <tr key={r.id_HoaDonNhap ?? r.id_HoaDonNhapHang ?? r.id_HoaDon}>
                    <td>{r.id_HoaDonNhap ?? r.id_HoaDonNhapHang ?? r.id_HoaDon}</td>
                    <td>{r.nhaCungCap?.tenNhaCungCap ?? r.nhaCungCap?.ten ?? '-'}</td>
                    <td>
                      {r.ngayLapHoaDon
                        ? new Date(r.ngayLapHoaDon).toLocaleDateString()
                        : '-'}
                    </td>
                    <td>{r.trangThai === 1 ? 'Đã nhập' : 'Mới tạo'}</td>
                    <td>{r.tongTien ? formatCurrency(r.tongTien) : '-'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            {!receipts.length && <div className="text-muted">Chưa có phiếu nhập.</div>}
          </div>

          <hr className="my-4" />
          <h6 className="fw-semibold mb-3">Tạo phiếu nhập</h6>
          <form className="row g-3" onSubmit={submit}>
            <div className="col-md-4">
              <label className="form-label">Mã hóa đơn nhập</label>
              <input
                className="form-control"
                value={newReceipt.id}
                onChange={(e) => setNewReceipt((p) => ({ ...p, id: e.target.value }))}
                required
              />
            </div>
            <div className="col-md-4">
              <label className="form-label">Nhà cung cấp</label>
              <select
                className="form-select"
                value={newReceipt.supplier}
                onChange={(e) => setNewReceipt((p) => ({ ...p, supplier: e.target.value }))}
              >
                <option value="">Chọn NCC</option>
                {suppliers.map((s) => (
                  <option key={s.id_NhaCungCap} value={s.id_NhaCungCap}>
                    {s.tenNhaCungCap}
                  </option>
                ))}
              </select>
            </div>
            <div className="col-md-2 d-flex align-items-end">
              <button className="btn btn-success" type="submit">
                Tạo phiếu
              </button>
            </div>
          </form>
          <p className="text-muted small mt-2 mb-0">
            Sau khi tạo phiếu, dùng API <code>/api/admin/GoodsReceiptApi/&#123;id&#125;/items</code>{' '}
            để thêm dòng và <code>/import</code> để nhập kho.
          </p>
        </div>
      </div>
    </div>
  );
}

function formatCurrency(value: number | undefined | null) {
  const safeValue = Number(value ?? 0);
  return safeValue.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
}

export default App;

