function [f, u, w] = ecm_emc2s(x,pp)

% [f, u] = ecm_emc2s(x,pp)

delta_G_by_RT = pp.N_forward' * x - pp.log_Keq_forward;

w = [ pp.kc_forward .* [1 - exp(delta_G_by_RT)] ];
u = abs(pp.v) ./ w;

f = max(pp.enzyme_cost_weights .* u(pp.ind_scored_enzymes));

if sum(delta_G_by_RT>0),
  f = 10^20 * max(delta_G_by_RT);
end
