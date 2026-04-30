"use client";

import { useAuth } from "@/lib/auth-context";
import { useEffect, useState } from "react";
import Link from "next/link";

const FIREBASE_RTDB_URL = "https://qldclb-770f5-default-rtdb.asia-southeast1.firebasedatabase.app";

interface Notification {
  uid: string;
  message: string;
  link: string;
  time: number;
}

function formatTime(timestamp: number): string {
  const date = new Date(timestamp);
  return date.toLocaleString("vi-VN", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export default function NotificationsPage() {
  const { user, isAnonymous, isLoading: authLoading } = useAuth();
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (authLoading) return;
    if (!user || isAnonymous) {
      setLoading(false);
      return;
    }
    loadNotifications();
  }, [user, authLoading, isAnonymous]);

  const loadNotifications = async () => {
    try {
      const res = await fetch(`${FIREBASE_RTDB_URL}/notification.json`);
      if (!res.ok) throw new Error("Failed to fetch");
      const data = await res.json();

      if (!data) {
        setNotifications([]);
        setLoading(false);
        return;
      }

      // data is an object with push IDs as keys
      const allNotifs: Notification[] = Object.values(data);
      // Filter by current user's UID
      const userNotifs = allNotifs
        .filter((n) => n.uid === user!.uid)
        .sort((a, b) => b.time - a.time);

      setNotifications(userNotifs);
    } catch {
      setNotifications([]);
    } finally {
      setLoading(false);
    }
  };

  if (loading || authLoading) {
    return <div className="p-3 sm:p-4 lg:p-10 text-center text-gray-500">Đang tải...</div>;
  }

  if (!user || isAnonymous) {
    return (
      <div className="p-3 sm:p-4 lg:p-10">
        <div className="bg-white rounded-[20px] p-12 text-center">
          <p className="text-gray-500 mb-4">Vui lòng đăng nhập để xem thông báo.</p>
          <Link href="/sign-in" className="text-black hover:underline font-bold">
            Đăng nhập →
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="p-3 sm:p-4 lg:p-10">
      <h4 className="font-bold text-lg mb-4">Thông báo</h4>

      {notifications.length === 0 ? (
        <div className="bg-white rounded-[20px] p-12 text-center">
          <span className="material-symbols-outlined text-5xl text-gray-300 mb-3 block">notifications</span>
          <p className="text-gray-500">Chưa có thông báo</p>
        </div>
      ) : (
        <div className="space-y-3">
          {notifications.map((notif, index) => (
            <Link
              key={index}
              href={`/order/${encodeURIComponent(notif.link)}`}
              className="block bg-white rounded-[20px] p-4 hover:shadow-[0_4px_8px_rgba(0,0,0,0.1)] transition-shadow"
            >
              <div className="flex items-start gap-3">
                <span className="material-symbols-outlined text-gray-400 mt-0.5">notifications</span>
                <div className="flex-1 min-w-0">
                  <p className="text-sm text-black font-medium">{notif.message}</p>
                  <p className="text-xs text-gray-400 mt-1">{formatTime(notif.time)}</p>
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
