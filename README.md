# ỨNG DỤNG "ĐIỀU EM MUỐN NÓI" - XÃ TRÀ LIÊN, TP. ĐÀ NẴNG

Cổng lấy ý kiến trẻ em, thiếu nhi và thanh thiếu niên do **Đoàn TNCS Hồ Chí Minh xã Trà Liên** quản lý.

> **Khẩu hiệu:** “Lắng nghe tiếng nói – Tôn trọng ý kiến – Bảo vệ quyền lợi trẻ em, thanh thiếu niên”

---

## 🌟 TÍNH NĂNG NỔI BẬT

1. **Giao diện thân thiện cho thiếu nhi & học sinh**:
   - Màu xanh thanh niên kết hợp trắng hiện đại, tối ưu 100% trên điện thoại và máy tính.
   - Gửi ý kiến ẩn danh để bảo vệ danh tính và quyền riêng tư của các em.
   - Chọn đối tượng (Tiểu học / THCS / Khác), độ tuổi, thôn đang sống hoặc trường đang học.
   - 10 chủ đề sát thực tế: Học tập; Vui chơi giải trí; Bạo lực học đường; An toàn không gian mạng; Bảo vệ trẻ em; Môi trường; Hoạt động Đoàn - Đội; Quyền trẻ em; Tâm tư nguyện vọng; Đề xuất khác.
   - Cấp mã tiếp nhận tự động (Ví dụ: `TL-261009-A7B2`) kèm pháo hoa chúc mừng.
   - Tính năng **Tra cứu tiến độ xử lý** bằng mã tiếp nhận.

2. **Khu vực Quản trị cho Cán bộ Đoàn xã**:
   - Thống kê trực quan số lượng ý kiến theo trạng thái, đối tượng và chủ đề.
   - Bộ lọc đa năng: lọc theo trạng thái (Mới tiếp nhận / Đang xử lý / Đã phản hồi), đối tượng, chủ đề, độ tuổi, thôn/trường học và tìm kiếm từ khóa.
   - Cập nhật trạng thái xử lý và ghi chú phản hồi gửi trực tiếp đến người tra cứu.
   - **Xuất báo cáo CSV chuẩn tiếng Việt (UTF-8 BOM)** mở trực tiếp bằng Microsoft Excel không lỗi font.
   - Bảo mật dữ liệu trẻ em theo Luật Trẻ em 2016.

3. **Cơ sở dữ liệu Supabase Trực Tuyến**:
   - Kết nối Supabase lưu trữ đám mây thực tế 100%.
   - Thiết lập Row Level Security (RLS) bảo vệ dữ liệu.
   - Tích hợp cửa sổ cấu hình trực tiếp ngay trên giao diện web.

---

## 🚀 HƯỚNG DẪN CẤU HÌNH SUPABASE (LƯU DỮ LIỆU THẬT)

1. Đăng ký/Đăng nhập tại [https://supabase.com](https://supabase.com) (Miễn phí).
2. Tạo một Project mới (chọn Region `Singapore` gần Việt Nam nhất).
3. Vào mục **SQL Editor** ở menu bên trái của Supabase:
   - Mở file `supabase_schema.sql` có sẵn trong thư mục này.
   - Dán toàn bộ nội dung và bấm **Run** để khởi tạo bảng `feedbacks` và phân quyền bảo mật RLS.
4. Vào **Project Settings** &rarr; **API**:
   - Sao chép **Project URL** (ví dụ: `https://xyz.supabase.co`).
   - Sao chép **anon public key**.
5. Nhập vào website:
   - Trên thanh điều hướng website, bấm nút **"Cấu hình Supabase"**.
   - Dán URL và Key vào rồi bấm **"Lưu & Kết Nối Supabase"**.
   - Hoặc tạo file `.env` với 2 dòng:
     ```env
     VITE_SUPABASE_URL=https://your-project.supabase.co
     VITE_SUPABASE_ANON_KEY=your-anon-key
     ```

---

## 🔐 TÀI KHOẢN ĐĂNG NHẬP CÁN BỘ ĐOÀN (MẶC ĐỊNH)

- **Tài khoản:** `doanxa@tralien.gov.vn`
- **Mật khẩu:** `TraLien2026@`

---

## 💻 CHẠY THỬ TRÊN MÁY TÍNH (LOCAL)

```bash
# Cài đặt thư viện
npm install

# Chạy môi trường phát triển
npm run dev

# Mở trình duyệt tại: http://localhost:5173
```

---

## 🌐 HƯỚNG DẪN TRIỂN KHAI LÊN VERCEL / NETLIFY (CÔNG KHAI LINK THẬT)

### Cách 1: Triển khai lên Vercel (Khuyên dùng)
1. Đăng ký tài khoản tại [https://vercel.com](https://vercel.com).
2. Tải mã nguồn lên GitHub (hoặc dùng Vercel CLI).
3. Trên Vercel Dashboard, chọn **Add New...** &rarr; **Project** &rarr; Chọn repository `ykien`.
4. Trong phần **Environment Variables**, thêm 2 biến:
   - `VITE_SUPABASE_URL`: Điền URL Supabase của bạn
   - `VITE_SUPABASE_ANON_KEY`: Điền Anon Key của bạn
5. Bấm **Deploy**. Sau 30 giây, Vercel sẽ cấp link công khai miễn phí dạng:  
   `https://dieu-em-muon-noi-tra-lien.vercel.app`

### Cách 2: Kéo thả thư mục Build lên Netlify Drop (Không cần Git)
1. Chạy lệnh đóng gói sản phẩm trên máy:
   ```bash
   npm run build
   ```
2. Thư mục `dist` sẽ được tạo ra.
3. Truy cập [https://app.netlify.com/drop](https://app.netlify.com/drop).
4. Kéo thả cả thư mục `dist` vào trang web của Netlify.
5. Netlify sẽ ngay lập tức cấp link trực tuyến công khai!
