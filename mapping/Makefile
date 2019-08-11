all:
	docker run -ti -v `pwd`:/data hjoest/alchemy learnwts -g -i mapping.mln -o mapping-out.mln -t mapping-train.db -ne MapsTo
	docker run -ti -v `pwd`:/data hjoest/alchemy infer -bp -i mapping-out.mln -r mapping.result -e mapping-test.db -q MapsTo
	cat mapping.result
