"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { SelectOption } from "@/lib/types";

interface Props {
  categories: SelectOption[];
  manufacturers: SelectOption[];
  currentFilters: {
    search?: string;
    sortColumn?: string;
    min?: string;
    max?: string;
    type?: string;
    manufacturer?: string;
  };
}

export default function ProductFilters({ categories, manufacturers, currentFilters }: Props) {
  const router = useRouter();
  const [type, setType] = useState(currentFilters.type || "");
  const [manufacturer, setManufacturer] = useState(currentFilters.manufacturer || "");
  const [sortColumn, setSortColumn] = useState(currentFilters.sortColumn || "");
  const [min, setMin] = useState(currentFilters.min || "");
  const [max, setMax] = useState(currentFilters.max || "");

  const applyFilters = () => {
    const params = new URLSearchParams();
    if (currentFilters.search) params.set("search", currentFilters.search);
    if (type) params.set("type", type);
    if (manufacturer) params.set("manufacturer", manufacturer);
    if (sortColumn) params.set("sortColumn", sortColumn);
    if (min) params.set("min", min);
    if (max) params.set("max", max);
    router.push(`/products?${params}`);
  };

  const resetFilters = () => {
    router.push("/products");
  };

  return (
    <ul className="bg-[#fbf1f1] rounded-[20px] py-2.5 list-none m-0 p-0">
      <li className="px-4 py-2 hover:bg-[#f8d9d6] rounded-[20px]">
        <select
          value={manufacturer}
          onChange={(e) => setManufacturer(e.target.value)}
          className="w-full bg-transparent border-0 p-0 text-sm focus:outline-none cursor-pointer"
        >
          <option value="">Nhà sản xuất</option>
          {manufacturers.map((m) => (
            <option key={m.value} value={m.value}>{m.text}</option>
          ))}
        </select>
      </li>
      <li className="px-4 py-2 hover:bg-[#f8d9d6] rounded-[20px]">
        <select
          value={type}
          onChange={(e) => setType(e.target.value)}
          className="w-full bg-transparent border-0 p-0 text-sm focus:outline-none cursor-pointer"
        >
          <option value="">Thể loại</option>
          {categories.map((c) => (
            <option key={c.value} value={c.value}>{c.text}</option>
          ))}
        </select>
      </li>
      <li className="px-4 py-2 hover:bg-[#f8d9d6] rounded-[20px]">
        <select
          value={sortColumn}
          onChange={(e) => setSortColumn(e.target.value)}
          className="w-full bg-transparent border-0 p-0 text-sm focus:outline-none cursor-pointer"
        >
          <option value="">Sắp xếp</option>
          <option value="1">Giá tăng dần</option>
          <option value="2">Giá giảm dần</option>
          <option value="3">Tên A-Z</option>
          <option value="4">Tên Z-A</option>
          <option value="5">Mới nhất</option>
          <option value="6">Bán chạy nhất</option>
        </select>
      </li>
      <li className="px-4 py-2">
        <div className="ml-4 space-y-2">
          <input
            type="number"
            value={min}
            onChange={(e) => setMin(e.target.value)}
            placeholder="Giá từ"
            min="1"
            className="w-[150px] bg-transparent border-0 p-0 text-sm focus:outline-none placeholder:text-black"
          />
          <input
            type="number"
            value={max}
            onChange={(e) => setMax(e.target.value)}
            placeholder="Đến"
            className="w-[150px] bg-transparent border-0 p-0 text-sm focus:outline-none placeholder:text-black"
          />
        </div>
      </li>
      <li className="px-4 py-2 flex gap-2">
        <button
          onClick={applyFilters}
          className="bg-[#212631] text-white rounded-[20px] px-6 py-1.5 text-sm font-bold"
        >
          Lọc
        </button>
        <button
          onClick={resetFilters}
          className="bg-gray-500 rounded-[20px] px-6 py-1.5 text-sm font-bold"
        >
          Bỏ lọc
        </button>
      </li>
    </ul>
  );
}
