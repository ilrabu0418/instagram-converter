#!/bin/bash

# 인스타그램 글 변환 후 본문/해시태그 각각 클립보드 복사
# 사용법: ./insta.sh "[글쓰기] 내용"

cd ~/instagram-converter

# Claude 실행하고 결과 저장
result=$(claude "$1")

# 화면에 결과 출력
echo "$result"
echo ""
echo "================================"

# 해시태그 추출 (# 로 시작하는 줄들)
hashtags=$(echo "$result" | grep -E "^#" | tr '\n' ' ')

# 본문 추출 (📝 변환된 글 다음부터 #️⃣ 전까지)
body=$(echo "$result" | sed -n '/^```$/,/^```$/p' | head -1 | sed '1d;$d')

# 본문이 비어있으면 다른 방식으로 추출
if [ -z "$body" ]; then
    body=$(echo "$result" | awk '/📝 변환된 글/{found=1; next} /^#️⃣|^💡/{found=0} found' | grep -v '```')
fi

# 1. 해시태그 먼저 클립보드에 복사
echo "$hashtags" | termux-clipboard-set
echo "✅ 해시태그 클립보드 복사 완료!"
echo ""

# 2초 대기 (클립보드 기록에 저장되도록)
sleep 2

# 2. 본문 클립보드에 복사
echo "$body" | termux-clipboard-set
echo "✅ 본문 클립보드 복사 완료!"
echo ""
echo "📋 클립보드 기록에서:"
echo "   1. 본문 (최근) - 먼저 붙여넣기"
echo "   2. 해시태그 (이전) - 댓글에 붙여넣기"
