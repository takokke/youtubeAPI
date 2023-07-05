require 'uri'
require 'net/http'
require 'json'

# 特定のユーチューブ動画の情報を取得する(id=任意の動画ID)

key = APIキー
url = "https://www.googleapis.com/youtube/v3/videos?id=Duo7_lF-oaE&key=#{key}&part=snippet,contentDetails,statistics,status"

uri = URI.parse(url)
res = Net::HTTP.get(uri) #レスポンシブを受け取る
res = JSON.parse(res)    #レスポンシブをJSON形式にする

#いいね数を取得
likeCount = res['items'][0]['statistics']['likeCount'].to_f
#チャンネルIDを取得
channelId = res['items'][0]['snippet']['channelId']

puts "#{res['items'][0]['snippet']['title']} 投稿者:#{res['items'][0]['snippet']['channelTitle']}"


#特定のチャンネルを取得
url_2 = "https://www.googleapis.com/youtube/v3/channels?id=#{channelId}&key=#{key}&part=statistics"

uri_2 = URI.parse(url_2)
res_2 = Net::HTTP.get(uri_2) #レスポンシブを受け取る
res_2 = JSON.parse(res_2)    #レスポンシブをJSON形式にする

#チャンネル登録者数を取得
subscriberCount = res_2['items'][0]['statistics']['subscriberCount'].to_f

#いいね率=いいね数 ÷ チャンネル登録者数　×　100
rate = likeCount / subscriberCount * 100

puts "\nチャンネル登録者数　#{subscriberCount.to_i}人"
puts "今回の動画のいいね数　#{likeCount.to_i}"

puts "\n…いいね率　#{rate}%"