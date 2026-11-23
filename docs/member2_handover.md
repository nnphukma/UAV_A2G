# Bàn giao của Thành viên 2 – MATLAB

**Mục tiêu:** Bàn giao mô hình kênh A2G chạy độc lập và đầu ra CSV cố định.

## File phụ trách
- `main.m`, `config.m` – điều phối và cấu hình.
- `models/*.m` – hàm mô hình và Link Budget tùy chọn.
- `simulations/scenario_*.m` và `make_result_table.m` – 3 kịch bản.
- `tests/run_tests.m` – kiểm tra độc lập.
- `results/csv/*.csv` – chỉ được sinh bởi MATLAB khi chạy `main`.

## File phục vụ Thành viên 3
- `simulations/plot_results.m` – bản mẫu; Thành viên 3 sở hữu phiên bản cuối.
- `results/figures/*.png` – chỉ được sinh khi chạy `plot_results`.

## Giao diện khóa cứng
Tên hàm, đơn vị và cột CSV ghi trong README. Đổi interface phải thông báo cả nhóm.

## Việc cần từ Thành viên 1
1. Xác nhận biểu thức Al-Hourani và đơn vị theta (độ).
2. Xác nhận `a,b,eta_los_dB,eta_nlos_dB` cho Urban/Suburban.
3. Xác nhận phạm vi áp dụng bộ tham số ở tần số 2.4 GHz;
   nếu nguồn chỉ hỗ trợ 2 GHz hoặc tần số khác, cả nhóm thống nhất đổi `cfg.f_Hz`.
4. Sau khi phê duyệt có ghi nguồn ở `docs/parameters.md`, đặt
   `cfg.params_reviewed = true` và chạy lại toàn bộ CSV/PNG.

## Tình trạng
- MATLAB source: đã tạo.
- Kiểm tra logic toán học tham chiếu: đã thực hiện ngoài MATLAB.
- Kiểm thử thực tế trên MATLAB: **chưa thực hiện**, chờ máy người dùng.
- CSV chính thức: sẽ sinh khi nhóm chạy `main` với tham số đã duyệt.
