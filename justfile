update-glue tag="":
	@if [ -n "{{tag}}" ]; then \
		uv run scripts/update_glue.py --tag "{{tag}}"; \
	else \
		uv run scripts/update_glue.py; \
	fi
