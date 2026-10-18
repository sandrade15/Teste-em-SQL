--isso aqui serve pra testar se eu realmente consegui organizar os dados bonitinhos na camada de ouro ou se eu fiz besteira.

--expectativa de todos os testes: ZERO.

--aqui vai checar se tem alguma key de consumidor repetida no gold.dim_products

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

--aqui vai checar se tem alguma key de produto repetida no gold.dim_products

SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

--aqui embaixo vai checar entre o fact e o dim, se ta tudo ok.

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
