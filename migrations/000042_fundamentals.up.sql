BEGIN;

CREATE TYPE dimension AS ENUM ('As-Reported-Annual', 'Most-Recent-Annual', 'As-Reported-Quarterly', 'Most-Recent-Quarterly', 'As-Reported-Trailing12', 'Most-Recent-Trailing12');

ALTER TYPE datasource ADD VALUE IF NOT EXISTS 'sharadar.com';

CREATE TABLE IF NOT EXISTS fundamentals (
    event_date DATE,
    ticker TEXT,
    composite_figi TEXT,
    dim DIMENSION NOT NULL,

    cost_of_revenue NUMERIC,
    total_sell_gen_admin_exp NUMERIC,
    research_devel_exp NUMERIC,
    opex NUMERIC,
    interest_exp NUMERIC,
    tax_exp NUMERIC,
    net_income_discontinued_operations NUMERIC,
    consolidated_income NUMERIC,
    net_income_nci NUMERIC,
    net_income NUMERIC,
    pref_dividends NUMERIC,
    eps_diluted NUMERIC,
    wavg_shares_out NUMERIC,
    wavg_shares_out_diluted NUMERIC,
    capx NUMERIC,
    net_business_acquisitions_divestures NUMERIC,
    net_invest_acquisitions_divestures NUMERIC,
    free_cash_flow_per_share NUMERIC,
    net_cash_flow_from_financing NUMERIC,
    total_issuance_repayment_debt NUMERIC,
    total_issuance_repayment_equity NUMERIC,
    common_dividends NUMERIC,
    net_cash_flow_from_invest NUMERIC,
    net_cash_flow_from_oper NUMERIC,
    effect_of_fgn_exch_rate_on_cash NUMERIC,
    net_cash_flow NUMERIC,
    stock_based_comp NUMERIC,
    total_depreciation_amortization NUMERIC,
    total_assets NUMERIC,
    total_invest NUMERIC,
    curr_invest NUMERIC,
    non_curr_invest NUMERIC,
    deferred_revenue NUMERIC,
    total_deposits NUMERIC,
    net_property_plant_equip NUMERIC,
    inventory_sterm NUMERIC,
    tax_assets NUMERIC,
    total_receivables NUMERIC,
    total_payables NUMERIC,
    intangibles NUMERIC,
    total_liabilities NUMERIC,
    retained_earnings NUMERIC,
    accumulated_other_comprehensive_income NUMERIC,
    curr_assets NUMERIC,
    non_curr_assets NUMERIC,
    curr_liabilities NUMERIC,
    non_curr_liabilities NUMERIC,
    tax_liabilities NUMERIC,
    curr_debt NUMERIC,
    non_curr_debt NUMERIC,
    ebt NUMERIC,
    fgn_exchange_rate NUMERIC,
    equity NUMERIC,
    eps NUMERIC,
    total_revenue NUMERIC,
    net_income_common_stock NUMERIC,
    cash_equiv NUMERIC,
    book_value_per_share NUMERIC,
    total_debt NUMERIC,
    ebit NUMERIC,
    ebitda NUMERIC,
    shares_out NUMERIC,
    dividend_per_share NUMERIC,
    share_factor NUMERIC,
    market_cap NUMERIC,
    ev NUMERIC,
    invest_capital NUMERIC,
    equity_avg NUMERIC,
    assets_avg NUMERIC,
    invested_capital_avg NUMERIC,
    tangibles NUMERIC,
    roe NUMERIC,
    roa NUMERIC,
    free_cash_flow NUMERIC,
    ret_on_invested_capital NUMERIC,
    gross_profit NUMERIC,
    opinc NUMERIC,
    gross_margin NUMERIC,
    net_margin NUMERIC,
    ebitda_margin NUMERIC,
    return_on_sales NUMERIC,
    asset_turnover NUMERIC,
    payout_ratio NUMERIC,
    ev_to_ebitda NUMERIC,
    ev_to_ebit NUMERIC,
    pe NUMERIC,
    pe_alt NUMERIC,
    sales_per_share NUMERIC,
    price_to_sales_alt NUMERIC,
    price_to_sales NUMERIC,
    pb NUMERIC,
    debt_to_equity NUMERIC,
    dividend_yield NUMERIC,
    curr_ratio NUMERIC,
    working_capital NUMERIC,
    tangible_book_value_per_share NUMERIC,

    source datasource,
    created TIMESTAMP NOT NULL DEFAULT now(),
    lastchanged TIMESTAMP NOT NULL DEFAULT now(),

    PRIMARY KEY (composite_figi, dim, event_date)
);

CREATE INDEX fundamentals_ticker_idx ON fundamentals(ticker);
CREATE INDEX fundamentals_event_date_idx ON fundamentals(event_date);

ALTER TABLE eod ADD COLUMN market_cap NUMERIC(12, 4);
ALTER TABLE eod ADD COLUMN ev NUMERIC(12, 4);
ALTER TABLE eod ADD COLUMN pe NUMERIC(12, 4);
ALTER TABLE eod ADD COLUMN pb NUMERIC(12, 4);
ALTER TABLE eod ADD COLUMN ps NUMERIC(12, 4);
ALTER TABLE eod ADD COLUMN ev_ebit NUMERIC(12, 4);
ALTER TABLE eod ADD COLUMN ev_ebitda NUMERIC(12, 4);

COMMIT;