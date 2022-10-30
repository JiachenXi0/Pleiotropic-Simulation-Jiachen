library(PleioSim)
set.seed(492357816)

for(distro in seq(10, 100, 10)){
  for (genotypic_correlation in seq(0.05, 0.5, 0.05)){
    scenario = simulate_set_with_knowledge_base(
      n_sample = 50000,
      effectsize_knowledge_base = PleioSim::uniform0.5_efs,
      pleiotropic_distro = c(distro, 100, 100),
      genotypic_correlation = genotypic_correlation,
      environmental_correlation = 0,
      heritability = c(0.5, 0.5),
      within_trait_heterogeneous_effect = FALSE,
      cross_trait_heterogeneous_effect = FALSE,
      null_variants = 1000,
      null_eaf_min = 0.1,
      null_eaf_max = 0.9
    )
    scenario = run_regression(scenario)
    scenario = get_pleiotropy_statistics(scenario)
    scenario = plot_scenario(scenario)
    ggsave(filename = paste0("distro_",distro,"_gc_",genotypic_correlation,"_pleio_plt.png"),plot = scenario$visualization$pleio_plt,width = 10, height = 10, dpi = 600)
    ggsave(filename = paste0("distro_",distro,"_gc_",genotypic_correlation,"_cross_compare.png"),plot = scenario$visualization$cross_compare_plt,width = 5, height = 5, dpi = 600)
  }
}

