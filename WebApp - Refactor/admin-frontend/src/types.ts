export type AdminModel = {
  tenNguoiDung: string;
  matKhau?: string;
  quyen?: number;
  ten?: string;
  email?: string;
};

export type Product = {
  id_DungCu: number;
  tenDungCu: string;
  gia: number;
  giaNhap?: number;
  giaKhuyenMai?: number;
  soLuong?: number;
  moTa?: string;
  thongTin?: string;
  id_LoaiDungCu?: number;
  id_NhaCungCap?: number;
  id_NhaSanXuat?: number;
  hinhAnh?: string;
};

export type Category = {
  id_LoaiDungCu: number;
  tenLoaiDungCu: string;
};

export type Supplier = {
  id_NhaCungCap: number;
  tenNhaCungCap: string;
};

export type Manufactor = {
  id_NhaSanXuat: number;
  tenNSX: string;
};

export type Voucher = {
  id_MaGiamGia: string;
  giaTriGiam: number;
  moTa?: string;
};

export type OrderSummary = {
  stats?: {
    choGiao: number;
    dangGiao: number;
    daGiao: number;
    daHuy: number;
  };
  orders: OrderTransport[];
};

export type OrderTransport = {
  id_DHVC: number;
  tinhTrang?: number;
  phiVanChuyen?: number;
  trangThaiVanChuyen?: { tenTrangThai?: string; id_TrangThai?: number };
  donHang?: { id_DonHang: string; ngayDat?: string; tongTien?: number; trangThai?: string };
};

export type DashboardPayload = {
  summary: {
    doanhThuThangNay: number;
    tienVatThangNay: number;
    tienShipThangNay: number;
    doanhThuSauThuevaChiPhiThangNay: number;
    tienNhapHangThangNay: number;
    loiNhuanThangNay: number;
    vatThangNay: number;
    thangNay: number;
  };
  filter: {
    fromDate: string;
    toDate: string;
    doanhThuLoc: number;
    tienShipLoc: number;
    doanhThuSauThuevaChiPhiLoc: number;
    tienNhapHangLoc: number;
    tienLoiLoc: number;
    vatLoc: number;
  };
  today: {
    doanhThuHomNay: number;
    tienShipHomNay: number;
    doanhThuSauThuevaChiPhiHomNay: number;
    tienNhapHangHomNay: number;
    tienLoiHomNay: number;
    vatHomNay: number;
  };
  topProducts: {
    id_DungCu: number;
    tenSanPham: string;
    soLuongBanDuoc: number;
  }[];
};
