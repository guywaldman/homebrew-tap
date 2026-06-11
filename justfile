update formula tag="":
	@if [ -n "{{tag}}" ]; then \
		uv run scripts/update_formula.py "{{formula}}" --tag "{{tag}}"; \
	else \
		uv run scripts/update_formula.py "{{formula}}"; \
	fi

update-glue tag="":
	just update glue "{{tag}}"

update-wt tag="":
	just update wt "{{tag}}"
