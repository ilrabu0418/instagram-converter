#!/bin/bash

# 인스타그램 변환 시스템 Termux 설정 스크립트
# 사용법: bash setup.sh

echo "🔧 인스타그램 변환 시스템 설정 중..."

# 스크립트 실행 권한 부여
chmod +x ~/instagram-converter/insta.sh

# 기존 alias 제거 (중복 방지)
sed -i '/인글()/d' ~/.bashrc
sed -i '/인스()/d' ~/.bashrc
sed -i '/instagram-converter/d' ~/.bashrc

# 새 alias 추가
cat >> ~/.bashrc << 'EOF'
인글() {
    ~/instagram-converter/insta.sh "[글쓰기] $*"
}
인스() {
    ~/instagram-converter/insta.sh "[스토리] $*"
}
EOF

# 적용
source ~/.bashrc

echo ""
echo "✅ 설정 완료!"
echo ""
echo "📝 사용법:"
echo "   인글 오늘 껍데기 완판됐어요"
echo "   인스 지금 자리 있어요"
echo ""
echo "⚠️  터미널을 새로 열거나 'source ~/.bashrc' 입력 후 사용하세요"
