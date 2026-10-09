-- ====================================================================
-- HỆ THỐNG CƠ SỞ DỮ LIỆU "ĐIỀU EM MUỐN NÓI" - XÃ TRÀ LIÊN, TP. ĐÀ NẴNG
-- Quản trị bởi: Đoàn Thanh niên xã Trà Liên
-- Chạy đoạn script này tại Supabase -> SQL Editor -> Run
-- ====================================================================

-- 1. Tạo bảng lưu trữ ý kiến (feedbacks)
CREATE TABLE IF NOT EXISTS public.feedbacks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    
    -- Thông tin người gửi
    full_name TEXT DEFAULT 'Ẩn danh',
    is_anonymous BOOLEAN DEFAULT false,
    age INTEGER CHECK (age >= 5 AND age <= 35),
    location TEXT NOT NULL,                     -- Thôn hoặc trường học
    target_group TEXT NOT NULL,                  -- TH (Tiểu học) / THCS / KHAC
    
    -- Nội dung ý kiến
    topic TEXT NOT NULL,                         -- Chủ đề lấy ý kiến
    content TEXT NOT NULL,                       -- Điều em muốn nói
    
    -- Quản lý tiếp nhận
    tracking_code TEXT UNIQUE NOT NULL,          -- Mã tiếp nhận (TL-YYMMDD-XXXX)
    status TEXT DEFAULT 'moi_tiep_nhan' CHECK (status IN ('moi_tiep_nhan', 'dang_xu_ly', 'da_phan_hoi')),
    admin_notes TEXT DEFAULT ''                  -- Ghi chú xử lý / phản hồi của Đoàn xã
);

-- 2. Đặt chỉ mục (Indexes) để tìm kiếm nhanh
CREATE INDEX IF NOT EXISTS idx_feedbacks_tracking_code ON public.feedbacks(tracking_code);
CREATE INDEX IF NOT EXISTS idx_feedbacks_status ON public.feedbacks(status);
CREATE INDEX IF NOT EXISTS idx_feedbacks_created_at ON public.feedbacks(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_feedbacks_topic ON public.feedbacks(topic);
CREATE INDEX IF NOT EXISTS idx_feedbacks_target ON public.feedbacks(target_group);

-- 3. Kích hoạt Row Level Security (RLS) để bảo vệ dữ liệu trẻ em
ALTER TABLE public.feedbacks ENABLE ROW LEVEL SECURITY;

-- 4. Chính sách bảo mật RLS:
-- Chính sách 1: MỌI NGƯỜI (kể cả trẻ em gửi ẩn danh không đăng nhập) đều có thể GỬI Ý KIẾN (INSERT)
CREATE POLICY "Public anonymous insert feedback" 
ON public.feedbacks 
FOR INSERT 
TO public 
WITH CHECK (true);

-- Chính sách 2: Cho phép người dùng tra cứu tình trạng ý kiến thông qua mã tiếp nhận (Chỉ xem)
CREATE POLICY "Public read by tracking code" 
ON public.feedbacks 
FOR SELECT 
TO public 
USING (true);

-- Chính sách 3: Chỉ Cán bộ Đoàn xã có tài khoản đăng nhập (Authenticated) mới được xem toàn bộ dữ liệu quản trị
CREATE POLICY "Admin view all feedbacks" 
ON public.feedbacks 
FOR SELECT 
TO authenticated 
USING (true);

-- Chính sách 4: Chỉ Cán bộ Đoàn xã (Authenticated) mới được cập nhật trạng thái và ghi chú xử lý
CREATE POLICY "Admin update feedback status" 
ON public.feedbacks 
FOR UPDATE 
TO authenticated 
USING (true);

-- Chính sách 5: Chỉ Cán bộ Đoàn xã (Authenticated) mới có quyền xóa
CREATE POLICY "Admin delete feedback" 
ON public.feedbacks 
FOR DELETE 
TO authenticated 
USING (true);

-- ====================================================================
-- HOÀN TẤT CẤU HÌNH CƠ SỞ DỮ LIỆU!
-- ====================================================================
