# 解法1
def solve1(log_count, campaign_days, visitor_counts)
  # 区間平均を求める
  section_averages = []

  (0..log_count - campaign_days).each do |idx|
    section_averages << visitor_counts[idx..idx + campaign_days - 1].sum.fdiv(campaign_days)
  end

  # maxメソッドで、最大平均(max_average)を求める
  max_average = section_averages.max
  # countメソッドで、最大平均の数(キャンペーン候補)を求める
  candidate_count = section_averages.count(max_average)
  # find_indexメソッドで、キャンペーン最初の候補日を求める(index 0 が 1日目なので index + 1 とする)
  first_day = section_averages.find_index { |average| average == max_average } + 1

  # 結果を返す
  [candidate_count, first_day]
end

# 解法2
def solve2(log_count, campaign_days, visitor_counts)

  # 初期設定
  section_visitors = [visitor_counts[0..campaign_days - 1].sum]

  (1..log_count - campaign_days).each do |current_idx|
    remove_idx = current_idx - 1
    insert_idx = current_idx + campaign_days - 1

    section_visitors << section_visitors[-1] - visitor_counts[remove_idx] + visitor_counts[insert_idx]
  end

  # maxメソッドで、最大来場者数を求める
  max_visitors = section_visitors.max

  # countメソッドで、最大来場者数だった日数(キャンペーン候補)を求める
  candidate_count = section_visitors.count(max_visitors)
  # find_indexメソッドで、キャンペーン最初の候補日を求める(index 0 が 1日目なので index + 1 とする)
  first_day = section_visitors.find_index { |visitor_count| visitor_count == max_visitors } + 1

  # 結果を返す
  [candidate_count, first_day]
end

# タイムオーバーした問題を読み込む(ログ: n=300,000, キャンペーン: k=150,000)
#FILE_NAME = "failed_case.txt"
#file = File.open(FILE_NAME)

# ファイルを全て読み込み、改行を取り除いて行ごとの配列を作成する
#input_lines = file.readlines(chomp: true)
# 同じ処理
# lines = file.read.split("\n")

multi = 8
result = []
12.times do
  # 測定開始
  start = Time.now
  total = 0
  1..10 ** multi.times do
    (1..10 ** multi).each { |num| total += num }
  end
  # 測定終了
  result << Time.now - start
  #puts "#{Time.now - start} s\n"
  puts total
end
puts "10^#{multi}"
puts result.sort

exit

# ランダムシード
srand(0)
log_counts = [100000, 500000, 1000000, 5000000, 10000000]

log_counts.each do |log_count|
  campaign_days = log_count / 2
  visitor_counts = Array.new(log_count) { rand(101) }
  # 測定開始
  start = Time.now

  #puts "n = #{log_count}, k = #{campaign_days}"
  #puts solve2(log_count, campaign_days, visitor_counts).join(" ")

  num = 1
  10 ** 3.times { num += 1 }

  # 測定
  puts "#{Time.now - start} s\n"
end
