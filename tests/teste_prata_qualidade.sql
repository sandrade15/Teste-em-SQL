/*esse teste vai ver se eu fiz o trabalho certinho. vai checar se tem:
1 - key nula ou duplicada
2 - espaço nas strings indesejado
3 - consistencia no padrao dos dados
4 - se as datas tao corretas ( se nao tem nenhuma data futura por exemplo )
e no geral é isso eu acho, também checa se os dados tão agrupados corretamente mas isso é quase a mesma coisa da 3.

usar só depois de ja ter carregado a camada prata
*/

-- EXPECTATIVA PRA TODOS: NENHUM RESULTADO.

-- checa se tem cst_id repetido ou nulo
SELECT
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--cust_info pra baixo daqui!!!!--

-- checa espaço desnecessario
SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- checa distinto no negocio de casado solteiro etc
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;

--prd_info pra baixo aqui!!!!--

-- checa se pra um id tem mais de 1 ocorrencia ou se é nulo
SELECT
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--checa espaço desnecessario ( pra produto )
SELECT
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--checa se o custo é valido ( maior que 0 e nao nulo )
SELECT
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--checa distinto no prd_line
SELECT DISTINCT
    prd_line
FROM silver.crm_prd_info;

--checa se tem data final que vem antes de data inicial
SELECT
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--isso aqui checa do bronze mesmo pra ver se lá tem alguma data invalida--
SELECT
    NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
    OR LEN(sls_due_dt) != 8
    OR sls_due_dt > 20500101
    OR sls_due_dt < 19000101;

--checa data invalida ( se a data de pedido vem depois da data de envio )
SELECT
    *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

--checa se vendas = quantidade vezes preço. se nao for entao tem coisa errada
SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

--checa se alguem nasceu antes de 01/01/1924 ( espero que nao )
SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
   OR bdate > GETDATE();

--pra ver se tem gen repetido
SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;

--checa se cntry sao tudo distinto
SELECT DISTINCT
    cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

--cgeca espaco desnecessario
SELECT
    *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);

--checa se maintenance sao tudo distinto
SELECT DISTINCT
    maintenance
FROM silver.erp_px_cat_g1v2;
