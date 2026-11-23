# Hợp đồng kỹ thuật MATLAB v1.0

- Chỉ sử dụng MATLAB base; không yêu cầu Simulink hay toolbox trả phí.
- Dùng các đơn vị: f_Hz (Hz), r_m/h_m/hg_m/d_m (m), theta_deg (độ),
  fspl_dB/pl_avg_dB (dB), công suất dBm.
- Mọi hàm vật lý nằm trong `models/`. Hàm phải thuần tính toán.
- Chỉ sửa giá trị mô phỏng trong `config.m`, không hard-code tại scenario.
- `main.m` gọi đúng `scenario_distance`, `scenario_altitude`,
  `scenario_environment`; mỗi hàm xuất CSV tương ứng.
- `plot_results.m` chỉ được đọc CSV để vẽ đồ thị, không tính lại công thức.
- CSV schema chính thức: `scenario,environment,f_Hz,h_m,hg_m,r_m,d_m,theta_deg,fspl_dB,p_los,pl_avg_dB`.
- Nếu Thành viên 1 thay thông số môi trường: sửa `config.m`, chạy lại `main`
  và `plot_results`, không tự chỉnh CSV/PNG.
- Bản mặc định là tham số có trạng thái `PROVISIONAL`; không coi là kết quả đo.
- Hãy giữ file `.py` đã có nếu cần tham khảo, nhưng không sử dụng chúng trong pipeline MATLAB.
