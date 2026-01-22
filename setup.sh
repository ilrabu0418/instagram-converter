#!/bin/bash

# 인스타그램 변환 시스템 Termux 설정 스크립트
# 사용법: bash setup.sh

echo "🔧 인스타그램 변환 시스템 설정 중..."

# 기존 함수 제거 (중복 방지)
sed -i '/인글()/d' ~/.bashrc
sed -i '/인스()/d' ~/.bashrc
sed -i '/instagram-converter/d' ~/.bashrc
sed -i '/insta_result/d' ~/.bashrc
sed -i '/termux-clipboard-set/d' ~/.bashrc

# 새 함수 추가 (스크립트 파일 없이 직접 실행)
cat >> ~/.bashrc << 'ENDOFFILE'
인글() {
  cd ~/instagram-converter
  claude "[글쓰기] $*" | tee /tmp/insta_result.txt
  echo ""
  echo "================================"
  grep "^#" /tmp/insta_result.txt | tr '\n' ' ' | termux-clipboard-set
  echo "✅ 해시태그 복사 완료!"
  sleep 2
  cat /tmp/insta_result.txt | termux-clipboard-set
  echo "✅ 전체 결과 복사 완료!"
}
인스() {
  cd ~/instagram-converter
  claude "[스토리] $*" | tee /tmp/insta_result.txt
  echo ""
  echo "================================"
  grep "^#" /tmp/insta_result.txt | tr '\n' ' ' | termux-clipboard-set
  echo "✅ 해시태그 복사 완료!"
  sleep 2
  cat /tmp/insta_result.txt | termux-clipboard-set
  echo "✅ 전체 결과 복사 완료!"
}
ENDOFFILE

echo ""
echo "✅ 설정 완료!"
echo ""
echo "📝 사용법:"
echo "   인글 오늘 껍데기 완판됐어요"
echo "   인스 지금 자리 있어요"
echo ""
echo "⚠️  아래 명령어 실행 필수:"
echo "   source ~/.bashrc"
