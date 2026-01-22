#!/bin/bash

# 인스타그램 글/스토리 변환 후 본문/해시태그 각각 클립보드 복사
# 사용법:
#   ./insta.sh "[글쓰기] 내용"
#   ./insta.sh "[스토리] 내용"

cd ~/instagram-converter

# Claude 실행하고 결과 저장
result=$(claude "$1")

# 화면에 결과 출력
echo "$result"
echo ""
echo "================================"

# 글쓰기인지 스토리인지 확인
if [[ "$1" == *"[스토리]"* ]]; then
    # 스토리: 본문 추출 (📱 변환된 스토리 텍스트 다음부터)
    body=$(echo "$result" | awk '/📱 변환된 스토리 텍스트/{found=1; next} /^🎨|^💡/{found=0} found' | grep -v '```' | sed '/^$/d')

    # 스토리는 해시태그 없이 본문만 복사
    echo "$body" | termux-clipboard-set
    echo "✅ 스토리 텍스트 클립보드 복사 완료!"
    echo ""
    echo "📋 인스타 스토리에 바로 붙여넣기 하세요!"
else
    # 글쓰기: 해시태그 추출 (# 로 시작하는 줄들)
    hashtags=$(echo "$result" | grep -E "^#" | tr '\n' ' ')

    # 본문 추출 (📝 변환된 글 다음부터 #️⃣ 전까지)
    body=$(echo "$result" | awk '/📝 변환된 글/{found=1; next} /^#️⃣|^💡/{found=0} found' | grep -v '```' | sed '/^$/d')

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
fi
