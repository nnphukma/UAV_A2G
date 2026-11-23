# HỢP ĐỒNG KỸ THUẬT MATLAB – v2.0 (đã tiếp nhận TV1)

- Chỉ sử dụng MATLAB cơ bản; không yêu cầu Simulink hoặc toolbox bổ sung.
- Đơn vị cố định: `f_Hz` (Hz), khoảng cách và độ cao (m), `theta_deg` (độ), loss (dB).
- `models/*.m` là hàm tính thuần túy; không ghi file, không hard-code tham số môi trường.
- `config.m` lưu cài đặt, hai môi trường: Urban, Suburban.
- Bộ tham số đã được TV1 bàn giao, đối chiếu với Bor-Yaliniz et al. (2018), Table I; nguồn ghi trong `docs/parameters.md`.
- `f_Hz=2.4e9` là **giả định khảo sát**; không thể hiện số liệu đo thực nghiệm ở 2.4 GHz.
- `main.m` gọi `scenario_distance`, `scenario_altitude`, `scenario_environment`.
- Kết quả CSV nằm ở `results/csv/`: `distance.csv`, `altitude.csv`, `environment.csv`.
- Schema xem `docs/CSV_SCHEMA.md` (11 cột, không được đổi nếu chưa thống nhất).
- `plot_results.m` chỉ đọc CSV và vẽ 4 PNG; TV3 có thể chỉnh bố cục.
- TV2 phải chạy lại `run_tests`, `main` sau khi ghép bản cập nhật, và lấy CSV của MATLAB làm bản bàn giao chính thức.
- CSV đi kèm bản ZIP là **bản tham chiếu tính độc lập ngoài MATLAB** để đối chiếu số học, không khẳng định đã được MATLAB tạo.
