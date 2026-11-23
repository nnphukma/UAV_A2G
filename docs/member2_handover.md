# BÀN GIAO THÀNH VIÊN 2 – MATLAB A2G (sau khi nhận tham số TV1)

## 1. Trạng thái và nguồn
- TV1 đã bàn giao `docs/parameters.md`, `docs/references.md`, `docs/member1_handover.txt`.
- `config.m` dùng đúng Table I của Bor-Yaliniz et al. (2018):
  Suburban (4.88, 0.43, 0.1, 21), Urban (9.61, 0.16, 1, 20).
- `cfg.params_reviewed = true` nghĩa là **đã đối chiếu bộ tham số và nguồn**, không nghĩa là kênh đã được đo kiểm tại 2.4 GHz.
- Tần số 2.4 GHz, h=100 m, hg=1.5 m, r=500 m là giá trị kịch bản giả định.

## 2. Lệnh TV2 phải chạy trên MATLAB R2024b
Đặt Current Folder = thư mục gốc rồi chạy:
```matlab
addpath(genpath(pwd))
run_tests
main
```
Dự kiến: 28 kiểm tra PASS, 201 + 201 + 402 = 804 hàng dữ liệu.
Sau khi chạy trên máy, lấy ba CSV thực tế trong `results/csv/` làm đầu ra chính thức.

## 3. Bàn giao tối thiểu cho TV3
- `results/csv/distance.csv` – 201 hàng, kịch bản quét r=100…3000 m ở urban.
- `results/csv/altitude.csv` – 201 hàng, kịch bản quét h=20…300 m ở urban.
- `results/csv/environment.csv` – 402 hàng, quét cùng r để so sánh urban và suburban.
- `docs/parameters.md` – bộ tham số, công thức, giả định.
- `docs/references.md` – trích dẫn nguồn.
- `docs/CSV_SCHEMA.md` – schema cột và cách sử dụng.
- `simulations/plot_results.m` – script vẽ minh họa, TV3 có quyền phát triển hình thức.

## 4. Cam kết giao diện
Không thay tên cột hoặc đơn vị của CSV. `plot_results.m` chỉ đọc CSV; không tự tính lại mô hình.
Khi cấu hình đổi: TV2 chạy lại `main` rồi TV3 chạy lại `plot_results`.

## 5. Chưa được tuyên bố
Không có đo đạc thực tế, thông số máy thu, SNR/BER, xác suất mất liên lạc hoặc bán kính phủ sóng tối đa.
Mô hình đầu ra là `PL_avg` trung bình theo dB dựa trên xác suất LoS và suy hao bổ sung; không có fading ngẫu nhiên.

## 6. Kết quả chạy MATLAB
Theo ảnh TV2 gửi trước khi cập nhật hồ sơ: MATLAB R2024b đã PASS 14/14 và sinh ba CSV (804 hàng).
Đó là bản code trước khi cập nhật ghi chú kiểm chứng; **phải chạy lại `run_tests` và `main` của bản này** để xác nhận kết quả cuối.
