#!/bin/bash
cd ~/instagram-converter
claude "$1" | tee /tmp/insta_result.txt
echo ""
echo "================================"
grep "^#" /tmp/insta_result.txt | tr '\n' ' ' | termux-clipboard-set
echo "✅ 해시태그 복사 완료!"
sleep 2
cat /tmp/insta_result.txt | termux-clipboard-set
echo "✅ 전체 결과 복사 완료!"
echo "📋 클립보드 기록: 1.전체결과 2.해시태그"
