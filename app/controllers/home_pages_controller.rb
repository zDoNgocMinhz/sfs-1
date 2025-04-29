
require "csv"

DATA_LICENSE_PLATE = [
"60H22920", "60H22587", "60H22333", "60H22403", "60H22012", "60H22095", "60H22448", "60H22876", "60H22349", "60H22987",
"60H22204", "60H22154", "60H22852", "60H22808", "60H22521", "60H22826", "60H22572", "60H22356", "60H22058", "60H22451",
"60H22513", "60H22976", "60H22053", "60H22182", "60H22059", "60H22064", "60H22395", "60H22618", "60H22990", "60H22512",
"60H22384", "60H22461", "60H22164", "60H22319", "60H22144", "60H22894", "60H22731", "60H22125", "60H22834", "60H22152",
"60H22316", "60H22543", "60H22748", "60H22080", "60H22743", "60H22823", "60H22013", "60H22063", "60H22441", "60H22122",
"60H22662", "60H22327", "60H22214", "60H22023", "60H22093", "60H22955", "60H22962", "60H22342", "60H22717", "60H22205",
"60H22295", "60H22964", "60H22436", "60H22162", "60H22487", "60H22528", "60H22605", "60H22634", "60H22645", "60H22812",
"60H22055", "60H22155", "60H22355", "60H22126", "60H22145", "60H22146", "60H22165", "60H22194", "60H22253", "60H22341",
"60H22405", "60H22994", "60H22694", "60H22883", "60H22373", "60H22455", "60H22480", "60H22525", "60H22545", "60H22584",
"60H22641", "60H22648", "60H22658", "60H22690", "60H22691", "60H22747", "60H22780", "60H22797", "60H22837", "60H22932"
]
DATA_NAME_DRIVERS = [
  "BUI LAM TUAN", "BUI QUANG VI", "BUI QUOC TOAN", "BUI TUAN ANH", "CHAU THIEN THANH ANH QUOC",
  "CHU MANH CUONG", "DANG LONG HAI", "DANG TRAN THE SON", "DONG LIEU GIANG", "DU VAN DUC BAO",
  "DUONG NGOC QUANG", "DUONG THI VIET HA", "HA CONG TUNG", "HO VIET TUAN", "HOANG GIA DINH",
  "HOANG NGOC HA", "HOANG QUANG LUONG", "HOANG VAN CONG", "HOANG VAN DU", "HOANG VUONG THINH",
  "HUYNH TAN HIEP", "HUYNH THANH PHA", "LAM TUAN VU", "LE CANH MANH", "LE CHI DU", "LE CONG KHANH",
  "LE HUU QUAN", "LE THANH PHONG", "LE TIEN DUNG", "LE VAN HIEN EM", "LE VAN SUOT", "LE VAN TY",
  "LE VIET LUONG", "LE XUAN CHIEU", "LU TIEU LONG", "LUU DUC TRUNG", "NGO THI BANG QUYEN",
  "NGO THI HONG", "NGO XUAN TUYEN", "NGUYEN ANH TIEN", "NGUYEN CANH HUNG", "NGUYEN DINH DAM",
  "NGUYEN DUY PHAT", "NGUYEN HUE", "NGUYEN HUU PHAT", "NGUYEN HUU THANH", "NGUYEN HUU TRI",
  "NGUYEN MAU THIN", "NGUYEN MINH DUONG", "NGUYEN MINH VU", "NGUYEN THANH CUONG",
  "NGUYEN THANH PHONG", "NGUYEN THANH TAN", "NGUYEN THANH TAO", "NGUYEN THANH TRONG",
  "NGUYEN THANH UT", "NGUYEN THI THANH HUONG", "NGUYEN TIEN DAT", "NGUYEN TIEN LONG",
  "NGUYEN TIEN PHAT", "NGUYEN TIEN THIEN", "NGUYEN VAN LICH", "NGUYEN VAN LONG",
  "NGUYEN VAN THIEP", "NGUYEN VAN TU", "NGUYEN VIET SON", "NGUYEN VU HOANG MINH",
  "PHAM CONG", "PHAM MINH QUAN", "PHAM PHI LONG", "PHAM THANH KINH", "PHAM THI DUY HAN",
  "PHAM VAN DIEN", "PHAM VAN HOP", "PHAM VIET HUNG", "PHAN THANH TRIEU", "TA VAN HOA",
  "TRAN HUNG", "TRAN MINH TAN", "TRAN NGUYEN THANH CONG", "TRAN PHUONG DONG", "TRAN QUOC KHANH",
  "TRAN SI PHAP", "TRAN VAN TAM", "TRINH THE PHUONG", "VONG PHI CUONG", "VU MINH CHAU",
  "VU MINH TAI", "VU MINH THANG", "VU VAN HANG", "VU VAN LUONG", "VU VAN THANH", "VU VAN TUYEN",
  "VUONG QUOC NGOC", "TAO DUY HUNG", "QUACH HONG PHUONG", "LE VAN NAM", "NGUYEN VAN CUONG",
  "NGUYEN HUY SAM", "MAI THI NGA", "HOANG NGOC THANG", "HO VU HAI", "LE VAN BINH", "LE VAN HAI",
  "BUI VAN ANH", "LUONG VAN SINH", "NGUYEN HUYNH PHI HUNG", "NGUYEN MINH THANH",
  "NGUYEN PHU TUYEN", "NGUYEN TAT TU", "NGUYEN THANH DANH", "NGUYEN MINH TUAN",
  "NGUYEN VAN NGOC", "TRAN VAN DUC", "TRAN XUAN DONG", "THO THANH SON", "HO VIET HA",
  "HO VIET HAI", "NGO PHONG LINH", "NV 911 GF", "TRAN VAN TIEN",
  "NGUYEN THANH TUAN", "NGUYEN QUANG TRUONG", "NGUYEN DINH DUC", "NGUYEN ANH TUAN",
  "LE QUANG HOAI KIEN", "PHAM QUANG PHUC", "NGUYEN DUC DIEP"
]

class HomePagesController < ApplicationController
  protect_from_forgery except: :upload
  skip_before_action :verify_authenticity_token, only: :upload

  def index
  end
  def subscribe
    raw_ids = params[:ids] || ""
    ids = raw_ids.split(/[\s,]+/).map(&:strip).reject(&:blank?)
    headers = {
      "accept" => "application/json",
      "accept-language" => "en",
      "authorization" => "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJjYzQ2MDc1My0yMTg4LTRmNjktYTU1YS02ZTExNjRmZTU2MGYiLCJhdWQiOiJhZG1pbl9wb3J0YWwiLCJwbGF0Zm9ybSI6IndlYnNpdGUiLCJpYXQiOjE3NDQ1NTcxNTUsInN1YiI6ImFjZmUzZjE5LWRiZWMtNDFhOC04NTA2LWFmYTY1NmVjYmI4ZCIsInJvbGUiOiJwYXJ0bmVyIiwiZW1haWwiOiJhZG1pbkA5MTF0YXhpLnZuIiwicGhvbmUiOiIrODQwOTQ1OTExOTExIiwiY291bnRyeV9jb2RlIjoiVk5NIiwicGFydG5lcl9pZCI6IjFiZTdmYjIxLTE4NmEtNDQwNi05ODkzLTI0NzljNTBiMjc0MCIsIm5hbWUiOiI5MTEgVGF4aSJ9.R-pPGgkYPLoSpH__RTB7s0Xc5iTn8ISLPx8CAojL06HA1hXQyJPd_VdSPrnry1QZDxhCHrO10rEMqfkieiNQRjzhaOCJu9lWMdTzix2qWY6-ojisNE4-tE5HuhfU3QE_VfWIsLwhgvotoX09aasCPaGTYwmHm6872SsAI01Sj-yxG-VGHWPNPleA8gWbzFge2f5ceIyCBFMvimV0mqsrl5_rq2NBVyOWvdrZ0J6B7xK4m_D2AyhuIQJUkyJCGIkvDT9TBssBHyzHH3oF35NZQR__NUoympxk2Yzgq5nCkTPjDVlOmPp7wtfkvmj2IdG20HJhVAocC6Tj5n_OilVCDsJwhRwJGcRPNeyFFu3-aCRxSxJlsVD8sM635M2El8vH8byGW9GlAN16pbQ-xbl1uLaTa3QA9-60QHm92Mdc1_64SJETkDenimDJpP7O7KA31b3dW5qF4G7L-rfUT5Yh0M45HoqWPNl16GQPp32uRgGnw6rbskySYKBZG8DRkhsORUXI0ZpV0ifSCzwaNefeDX461oJVCWUxkOSGnnFidOXIZ724jesnXgxjGQ8E9SoQySsuTGwBVXvQngQSnDL1w5v3ceGZEi989r0Ik_5SgFAOdaa7AC11lrHKIb4Q6luI0jbFah_s33sgzh-Gl7YprXF4nNe7owRI65sYP7ovZLo",
      "origin" => "https://admin-customer.xanhsm.com",
      "priority" => "u=1, i",
      "referer" => "https://admin-customer.xanhsm.com/",
      "sec-ch-ua" => '"Google Chrome";v="135", "Not-A.Brand";v="8", "Chromium";v="135"',
      "sec-ch-ua-mobile" => "?0",
      "sec-ch-ua-platform" => '"Windows"',
      "sec-fetch-dest" => "empty",
      "sec-fetch-mode" => "cors",
      "sec-fetch-site" => "cross-site",
      "user-agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36"
    }


    results = Parallel.map(ids, in_threads: 5) do |id|
      url = "https://api.gsm-api.net/order/v2/public/orders/#{id}?extra_components=path%2Cdriver%2Ccustomer%2Cfee%2Crating%2Ctrip%2Ctip%2Cinvoice%2Ccreator%2Cexpress%2Ccompleted_by%2Cchange_destination_log&01JRQV5PJKYAN06J3WRDAG315Y%0A01JRQV3D0W83DRJVTES40G1S3K%0A01JRQV14QENJ3PFGJBR88MPE54%0A01JRQV0YB0X1V5TK2KV2PNET2T%0A01JRQV0M8K7KCZNX2X8PM1N7EW%0A01JRQTWJ90KX69Y9TA0Y05DWAV%0A01JRQTW90YW0R4T86T5P44GW2K%0A01JRQTR6WBAQRQ5E1GQ0688F51%0A01JRQTQX9VEVT9NVMNEGHB4QBV%0A=null"
      begin
        response = HTTParty.get(url, headers: headers).parsed_response
        data = Hashie::Mash.new(response).data
        { id: id, fee: data.fee }
      rescue => e
        { id: id, error: e.message }
      end
    end

    # Xử lý và tạo file CSV
    csv_data = CSV.generate(headers: true) do |csv|
      # Ghi header
      csv << [ "id", "Tong thu", "Phi bao hiem", "Phi thu tai xe" ]

      # Ghi từng dòng
      results.each do |row|
        total_surcharge_cost = (row.dig(:fee, "fee_breakdown", "surcharge_fee_breakdown") || [])
        .select { |x| [ "surcharge_road_tax", "surcharge_other_tax" ].include?(x["name"]) }
        .map { |x| x["cost"].to_f }
        .sum
        csv << [
          row[:id],
          row.dig(:fee, "total_pay"),
          row.dig(:fee, "insurance_fee"),
          total_surcharge_cost
         ]
      end
    end

    # Gửi file CSV đã tạo
    bom = "\uFEFF"
    send_data bom + csv_data,
              filename: "fees.csv",
              type: "text/csv; charset=utf-8",
              disposition: "attachment"
    # if @response.success?
    #   data = JSON.parse(@response.body)
    #   @payment = Hashie::Mash.new(data).data.fee
    #   surcharge_fee = @payment.fee_breakdown&.dig(:surcharge_fee_breakdown, 0, :cost) || 0
    #   addon_fee     = @payment.fee_breakdown&.dig(:addon_fee_breakdown, 0, :cost) || 0

    #   @total = @payment.total_pay - surcharge_fee - addon_fee

    #   respond_to do |format|
    #     format.turbo_stream # 👈 render turbo stream template
    #     format.html { render :subscribe } # fallback nếu không dùng turbo
    #   end
    # else
    #   render turbo_stream: turbo_stream.replace("posts-container", partial: "shared/error", locals: { message: "Không thể lấy dữ liệu." })
    # end
  end

  def upload
    uploaded_file = params[:file]
    if uploaded_file.nil?
      redirect_to root_path, alert: "Vui lòng chọn file CSV."
      return
    end
    modified_rows = []
    csv_text = uploaded_file.read
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      string = row["Noi dung"]&.upcase
      cleaned_string = string&.gsub(/[^a-zA-Z0-9]/, "")
      lisence_valid = cleaned_string.nil? ? "" : DATA_LICENSE_PLATE.find { |lisence| cleaned_string.include?(lisence) }
      message = string&.match(/TRACE\s*(.*?)(?:\s*chuyen tien|$)/i)&.captures&.first&.strip || ""
      debt = row["Ghi no"] != "0" ? row["Noi dung"] : nil
      lisence_valid_or_mess = lisence_valid.nil? ? message : lisence_valid&.gsub(/^([a-zA-Z0-9]{3})(\d{3})(\d{2})$/, '\1-\2.\3 ck')&.downcase
      description = debt.present? ? debt : lisence_valid_or_mess
      name_driver = DATA_NAME_DRIVERS.find { |name| string&.include?(name&.strip) } || ""
      modified_rows << [
        row["Ngay giao dich"],
        row["Ghi no"],
        row["Ghi co"],
        description,
        "7",
        lisence_valid,
        row["So tham chieu"],
        row["Noi dung"],
        name_driver
      ]
    end

    csv_output = CSV.generate(headers: true) do |csv_builder|
      csv_builder << [ "Ngày giao dịch", "Ghi nợ", "Thành tiền", "Diễn giải",	"Trung tâm LN",	"Biển số xe", "Số tham chiếu", "Diễn giải đầy đủ", "Tên tài xế" ]
      modified_rows.each { |row| csv_builder << row }
    end

    bom = "\uFEFF"
    send_data bom + csv_output,
              filename: "ket_qua_xu_ly.csv",
              type: "text/csv; charset=utf-8",
              disposition: "attachment"
  end
end
