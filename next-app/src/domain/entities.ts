// Domain entities - Core business models

export interface DungCuModel {
  id_DungCu: number;
  tenDungCu: string;
  gia: number;
  giaKhuyenMai: number | null;
  moTa: string | null;
  hinhAnh: string | null;
  soLuong: number;
  daXoa: number;
  thongTin: string | null;
  giaNhap: number | null;
  id_LoaiDungCu: number | null;
  id_NhaCungCap: number | null;
  id_NhaSanXuat: number | null;
  loaiDungCu: LoaiDungCuModel | null;
  nhaCungCap: NhaCungCapModel | null;
  nhaSanXuat: NhaSanXuatModel | null;
}

export interface LoaiDungCuModel {
  id_LoaiDungCu: number;
  tenLoaiDungCu: string;
}

export interface NhaCungCapModel {
  id_NhaCungCap: number;
  tenNhaCungCap: string;
  diaChi: string | null;
  soDienThoai: string | null;
  email: string | null;
}

export interface NhaSanXuatModel {
  id_NhaSanXuat: number;
  tenNSX: string;
  diaChi: string | null;
  email: string | null;
}

export interface BannerModel {
  id_Banner: number;
  tenBanner: string | null;
  duongDan: string | null;
  lienKet: string | null;
}

export interface KhachHangModel {
  id_KhachHang: string;
  tenKhachHang: string | null;
  email: string | null;
  soDienThoai: string | null;
  diaChi: string | null;
  diemThuong: number | null;
}

export interface YeuThichModel {
  id_YeuThich: number;
  id_KhachHang: string;
  id_DungCu: number;
  sanPham: DungCuModel;
}

export interface ChiTietDonHangModel {
  id_ChiTietDonHang: number;
  id_DonHang: string;
  id_DungCu: number;
  soLuong: number;
  donGia: number;
  dungCu: DungCuModel | null;
}

export interface DonHangModel {
  id_DonHang: string;
  id_KhachHang: string | null;
  ngayDat: string;
  ngayGiao: string | null;
  tongTien: number;
  vat: number;
  tienGiamGia: number;
  tienDiemThuong: number;
  phiVanChuyen: number;
  trangThai: string | null;
}

export interface DonHangVanChuyenModel {
  id_DHVC: number;
  id_DonHang: string | null;
  phiVanChuyen: number | null;
  diaChiVanChuyen: string | null;
  tenKhachHang: string | null;
  soDienThoai: string | null;
  email: string | null;
  tinhTrang: number | null;
  trangThaiVanChuyen: TrangThaiVanChuyenModel | null;
  donHang: DonHangModel | null;
}

export interface TrangThaiVanChuyenModel {
  id_TrangThai: number;
  tenTrangThai: string | null;
}

export interface OrderHistoryResponse {
  success: boolean;
  donHang: DonHangModel[];
  chiTietDonHang: ChiTietDonHangModel[];
  donHangVanChuyen: DonHangVanChuyenModel[];
}

export interface OrderDetailResponse {
  success: boolean;
  donHang: DonHangModel;
  chiTietDonHang: ChiTietDonHangModel[];
  donHangVanChuyen: DonHangVanChuyenModel;
}

export interface SelectOption {
  value: string;
  text: string;
}

export interface ApiResponse<T = unknown> {
  success: boolean;
  message?: string;
  data?: T;
}

export interface AuthResponse {
  success: boolean;
  token: string;
  expires: string;
  message?: string;
  data: {
    uid: string;
    email: string;
    tenKhachHang: string | null;
    soDienThoai: string | null;
    diaChi: string | null;
    diemThuong: number | null;
  };
}

export interface HomeDataResponse {
  success: boolean;
  banners: BannerModel[];
  saleOffProducts: DungCuModel[];
  newProducts: DungCuModel[];
  discountPercentages: (number | null)[];
}

export interface ProductFilterResponse {
  success: boolean;
  data: DungCuModel[];
  totalPages: number;
  currentPage: number;
}

export interface FilterOptionsResponse {
  success: boolean;
  categories: SelectOption[];
  manufacturers: SelectOption[];
}

export interface CartResponse {
  success: boolean;
  data: {
    orderId: string;
    tongTien: number;
    vat: number;
    tienGiamGia: number;
    tamTinh: number;
  } | null;
  items: ChiTietDonHangModel[];
  itemCount: number;
}

export interface CheckoutResponse {
  success: boolean;
  customer: {
    email: string;
    diaChi: string;
    soDienThoai: string;
    tenKhachHang: string;
    diemThuong: number;
  } | null;
  order: {
    tongTien: number;
    vat: number;
    tienGiamGia: number;
    tamTinh: number;
    itemCount: number;
  } | null;
  items: ChiTietDonHangModel[];
  paymentMethods: SelectOption[];
}
