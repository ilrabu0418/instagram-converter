#!/bin/bash

# 인스타그램 글/스토리 변환 후 클립보드 복사
# 사용법:
#   ./insta.sh "[글쓰기] 내용"
#   ./insta.sh "[스토리] 내용"

cd ~/instagram-converter

# Claude 실행하고 결과를 파일에 저장
claude "$1" | tee /tmp/insta_result.txt

echo ""
echo "================================"

# 결과 파일에서 해시태그 추출 (#로 시작하는 줄)
hashtags=$(grep -E "^#" /tmp/insta_result.txt | tr '\n' ' ')

# 결과 파일에서 ``` 사이의 본문 추출 (첫 번째 코드블록)
body=$(sed -n '/^```$/,/^```$/p' /tmp/insta_result.txt | sed '1d;$d')

# 해시태그가 있으면 복사
if [ -n "$hashtags" ]; then
    echo "$hashtags" | termux-clipboard-set
    echo "✅ 해시태그 클립보드 복사 완료!"
    sleep 2
fi

# 본문이 있으면 복사
if [ -n "$body" ]; then
    echo "$body" | termux-clipboard-set
    echo "✅ 본문 클립보드 복사 완료!"
else
    # 본문 추출 실패시 전체 결과 복사
    cat /tmp/insta_result.txt | termux-clipboard-set
    echo "✅ 전체 결과 클립보드 복사 완료!"
fi

echo ""
echo "📋 클립보드 기록에서 붙여넣기 하세요!"
