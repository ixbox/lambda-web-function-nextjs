NAME       ?= nextjs
REGION     ?= ap-northeast-1
STANDALONE := .next/standalone

.PHONY: build deploy clean

build:
	npm run build
	# public が存在する場合のみコピー
	if [ -d public ]; then cp -r public $(STANDALONE)/; fi
	cp -r .next/static $(STANDALONE)/.next/

deploy: build
	aws lambda-web deploy --name $(NAME) --code $(STANDALONE)/ --create --region $(REGION)

clean:
	rm -rf .next
