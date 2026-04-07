Page 1
Newton Article

Atomic hopping induced dynamic disorder phonon scattering and suppressed thermal transport in Cu₄TiSe₄
Graphical abstract
<img>A 3D atomic structure diagram showing Cu₁, Cu₂ (1a), Cu₂ (4e), Ti, Se, and different copper positions (16% Cu, 34% Cu). A wave vector plot is also shown.</img>

<img>A line graph plotting temperature (K) on the x-axis and k_L (W m⁻¹ K⁻¹) on the y-axis. Data points include Exp. (Koley et al.), Exp. (Lakshan et al.), BTE, 3ph (Chen et al.), BTE, 3+4ph (Chen et al.), BTE, 3ph, BTE, 3+4ph, EMD, SAEMD, and LFA. The graph shows a decrease in k_L with increasing temperature, with arrows indicating "4-phonon scatterings" and "dynamic disorder phonon scatterings". The legend indicates the methods used for each data point.</img>

Authors
Ruihuan Cheng, Wenxuan Wang, Wei Wang, ..., Niuchang Ouyang, Qi Liu, Yue Chen

Correspondence
yuechen@hku.hk

In brief
Some materials are extremely poor heat conductors, a property crucial for thermoelectric applications, yet the microscopic mechanisms remain poorly understood. In this study, Chen and colleagues study the anharmonic lattice dynamics and thermal transport in Cu₄TiSe₄ using molecular dynamics simulations with machine learning potentials. They find that thermally activated Cu2 hopping induces dynamic disorder with negligible convective heat flux, suppressing long-wavelength phonons and resulting in ultralow, weakly temperature-dependent thermal conductivity.

Highlights
Dynamic disorder scattering suppresses phonon transport in Cu₄TiSe₄
Cu2 atomic hopping induces strong phonon scattering with negligible convective heat transfer
Ultralow thermal conductivity arises from suppressed long-and short-wavelength phonons
MD simulations combined with MLP bridge the gap between theoretical and experimental κ_L
<img>Check for updates icon</img> Cheng et al., 2025, Newton 1, 100090 June 2, 2025 © 2025 The Author(s). Published by Elsevier Inc. https://doi.org/10.1016/j.newton.2025.100090

<img>CellPress logo</img>

Page 2
<img>Newton</img> <img>CellPress OPEN ACCESS</img>

Article

Atomic hopping induced dynamic disorder phonon scattering and suppressed thermal transport in Cu₄TiSe₄
Ruihuan Cheng,¹ Wenxuan Wang,¹ Wei Wang,² Xingyu Wang,² Chen Wang,¹,⁴ Siu Ting Tai,¹ Niuchang Ouyang,¹,³ Qi Liu,² and Yue Chen¹,⁵,*

¹Department of Mechanical Engineering, The University of Hong Kong, Pokfulam Road, Hong Kong SAR, China ²Department of Physics, City University of Hong Kong, Hong Kong SAR, China ³Mechanical Engineering and Materials Science, Duke University, Durham, NC, USA ⁴Present address: Institute for Advanced Study, Shenzhen University, Shenzhen 518060, China ⁵Lead contact *Correspondence: yuechen@hku.hk https://doi.org/10.1016/j.newton.2025.100090

ACCESSIBLE OVERVIEW Ultralow lattice thermal conductivity refers to the significantly reduced ability of a material’s lattice structure to conduct heat. Understanding the mechanisms behind this property is crucial for thermoelectric and thermal insulation materials. This study investigates the anharmonic lattice dynamics and thermal transport in Cu₄TiSe₄ using molecular dynamics simulations combined with machine learning potentials. Cu₂ atoms are found to undergo thermally activated hopping between adjacent sites, inducing dynamic disorder phonon scattering while contributing negligibly to convective heat flux. This results in significant suppression of long-wavelength acoustic phonons and the breakdown of short-wavelength Cu₂-dominated phonons near the Brillouin zone boundary, leading to exceptionally low and weakly temperature-dependent thermal conductivity. The dominant role of phonon disorder scattering accounts for the discrepancy between previous theoretical predictions and experimental measurements of the thermal transport properties of Cu₄TiSe₄. These insights highlight the interplay between atomic dynamics and phonon scattering, offering new strategies for engineering materials with ultralow thermal conductivity.

SUMMARY
Thermal transport in electrical insulators is governed by phonons, which are strongly influenced by atomic dynamics. Fast atomic diffusion enhances phonon scattering in superionic materials but causes uncompromising convectional heat flux, leading to an increase in lattice thermal conductivity (κ_L) with temperature. Here, we performed molecular dynamics simulations with machine learning potential, uncovering the hopping behavior of Cu₂ atoms in Cu₄TiSe₄ between adjacent sites 1a and 4e, which exhibit much lower diffusion coefficients compared to those in typical superionic materials. This hopping behavior induces additional dynamic disorder scattering, while its contribution to convectional heat flux is negligible, as evidenced by the decreased κ_L with rising temperature in both experiments and calculations. The dynamic disorder is sufficiently strong to inhibit the propagation of Cu₂-dominated short-wavelength phonons near the Brillouin zone boundary and greatly enhances the scattering of long-wavelength acoustic phonons in Cu₄TiSe₄. Further analysis of mode-projected phonon linewidths reveals that the dynamic disorder significantly enhances phonon scatterings and plays a dominant role in thermal transport, elucidating the mechanism behind the remarkably low κ_L of Cu₄TiSe₄. This work provides insights into the correlation between atomic dynamics and phonon scattering, offering potential avenues for the discovery and phonon engineering of ultralow-κ_L materials.

INTRODUCTION
In the energy conversion process, a certain proportion of heat is released as an inherent byproduct. This can be effectively mitigated through the use of thermal barrier coatings and refractory materials.¹,² Alternatively, this waste heat can be harnessed to generate electrical energy via the thermoelectric effect. Promising thermoelectric materials typically exhibit extremely low

<img>Check for updates</img> Newton 1, 100090, June 2, 2025 © 2025 The Author(s). Published by Elsevier Inc. This is an open access article under the CC BY-NC-ND license (http://creativecommons.org/licenses/by-nc-nd/4.0/).
<page_number>1</page_number>
Page 3
<img>CellPress OPEN ACCESS</img> <img>Newton Article</img>

Figure 1. Crystal structure and atomic dynamics of Cu₄TiSe₄

(A and B) The crystal structures of (A) ordered Cu₄TiSe₄ and (B) Cu₄TiSe₄ with disordered Cu₂ sites, which are visualized using the visualization for electronic and structural analysis (VESTA) package.⁵¹

(C) The MSD of Cu₂ atoms calculated from MD simulations at different temperatures. Inset: comparison of the computed D of Cu₂ in Cu₄TiSe₄ with that of Ag/Cu atoms in Cu₂Se,⁵² Cu₇PSe₆,³⁹ Ag₈SnSe₆,⁴² and AgCrSe₂ at 400 K.

(D) MD trajectories of Cu₁, Cu₂, Ti, and Se atoms in one unit cell of Cu₄TiSe₄ at different temperatures.

<img>Crystal structure of Cu₄TiSe₄ showing Cu1, Cu2 (1a), Cu2 (4e), Ti, Se, 16% Cu, and 34% Cu atoms.</img> <img>MSD vs Time plot for Cu₄TiSe₄, Cu₂Se, Cu₇PSe₆, Ag₈SnSe₆, and AgCrSe₂ at 200 K, 300 K, and 400 K.</img> <img>3D plot of MD trajectories for Cu₄TiSe₄ at 200 K.</img> <img>3D plot of MD trajectories for Cu₄TiSe₄ at 300 K.</img> <img>3D plot of MD trajectories for Cu₄TiSe₄ at 400 K.</img>

AgCrSe₂,³⁷,³⁸ Cu₇PSe₆,³⁹ AgCuX (X = Se and Te),⁴⁰,⁴¹ and Ag₈SnSe₆,⁴² strong anharmonicity induced by large-amplitude rattlers can suppress κ_L below the superionic transition temperature. In their superionic state, while the liquid-like movement of ions disrupts acoustic phonon transport, increasing atomic diffusion rates with temperature promote convective thermal flux, enhancing thermal transport.³⁶,³⁸,³⁹,⁴²–⁴⁵

Recently, the ternary copper-metal-chalcogenide Cu₄TiSe₄ has been synthesized, demonstrating an exceptionally low κ_L of 0.19 W m⁻¹ K⁻¹ at 300 K.⁴⁶

However, existing theoretical calculations significantly overestimate the κ_L of Cu₄TiSe₄, even when accounting for four-phonon scattering processes,⁴⁷ with reported theoretical values ranging from 2 to 2.2 W m⁻¹ K⁻¹ at 300 K.⁴⁷,⁴⁸ Therefore, the mechanisms behind the extremely low κ of Cu₄TiSe₄ have not been fully elucidated. Materials with partial atomic occupancy, such as Cu₆Te₃S, exhibit κ as low as 0.3 W m⁻¹ K⁻¹ at room temperature, indicating that crystallographic occupancy is a key factor in low-κ materials.⁴⁹ The partial atomic occupation of Cu₄TiSe₄, as highlighted by Koley et al.,⁴⁶ remains inadequately addressed in previous theoretical studies, underscoring the need for further research to fully comprehend its impact on lattice dynamics and thermal transport.

In this work, we construct an accurate machine learning moment tensor potential (MTP)⁵⁰ for Cu₄TiSe₄, derived from first-principles calculations using an active learning strategy. By utilizing the constructed MTP, we perform systematic molecular dynamics (MD) simulations to elucidate the atomic dynamics and phonon behaviors of Cu₄TiSe₄. Our results reveal hopping behavior of Cu₂ within the rigid lattices composed of Cu₁, Ti, and Se atoms, which aligns with the identified partial occupancy of Cu₂ atoms at five different coordinates.⁴⁶ Using the finite-displacement method, previous studies by Chen et al. and Zhang et al.⁴⁸ adopted an ordered structure (Figure 1A), neglecting dynamic disorder phonon scattering induced by atomic hopping. By considering dynamical disorder phonon scattering, this work bridges the gap between the theoretical and the experimental κ_L of Cu₄TiSe₄. Furthermore, we demonstrate that atomic hopping significantly impedes the propagation of

thermal conductivities.³–⁵ Consequently, the ongoing pursuit of novel crystalline materials with ultralow thermal conductivity (κ) has garnered significant attention, as studying the underlying mechanism of low κ helps unravel the complex correlations among crystal structure, bonding, and anharmonic lattice dynamics.

Within the framework of kinetic theory,⁶ various mechanisms exist for identifying low-lattice κ (κ_L) materials, described by the formula κ_L = 1/3C_Vv_g²τ, where C_V, v_g, and τ are the specific heat at constant volume, phonon group velocity, and phonon relaxation time, respectively. Strong intrinsic phonon-phonon scattering, induced by factors such as anharmonicity,⁷,⁸ lone-pair electrons,⁹–¹² mixed anions,¹³,¹⁴ resonant bonding,¹⁵–¹⁷ and rattling atoms,¹¹,¹⁸,¹⁹ can lead to short τ. On the other hand, v_g of phonons is determined by v_g ∝ √(k/M),⁶ where k and M represent bond stiffness and atomic mass, respectively; thus, materials with weaker bond strength and heavier atomic mass typically exhibit reduced v_g. For instance, strong anharmonicity results in Tl₃VSe₄ having an exceptionally low κ_L of 0.3 W m⁻¹ K⁻¹ at 300 K,²⁰ while the Zintl-type TlInTe₂ shows a low κ_L of 0.5 W m⁻¹ K⁻¹ at 300 K due to weakly bonded Tl cations acting as intrinsic rattlers.²¹ Additionally, defect engineering, including vacancy,²² interstitial site doping,²³,²⁴ dislocation,²⁵ and grain boundary,²⁶ as well as strain engineering²⁷–²⁹ can introduce further phonon scattering in materials, directly modifying lattice dynamics to reduce phonon relaxation time and impede thermal transport.

In phonon-liquid electron-crystal (PLEC) compounds, such as Cu₂Se,³⁰ CuCrSe₂,³¹ Cu₃SbSe₃,³²,³³ KAg₃Se₂,³⁴–³⁶

<page_number>2</page_number> Newton 1, 100090, June 2, 2025

Page 4
Newton Article

<img>CellPress OPEN ACCESS</img>

Figure 2. Structural and thermal transport characterization of Cu₄TiSe₄

(A) Rietveld refinement of Cu₄TiSe₄ neutron diffraction data measured at 300 K. The cross symbols represent the experimental data, while the green line corresponds to the calculated diffraction pattern. The red line indicates the background scattering, and the cyan line displays the difference between the experimental and calculated profiles. The vertical tick marks denote the allowed Bragg reflection positions. The refinement yields a good fit with a weighted profile R factor (R_w) of 4.172%.

(B) Scanning electron microscopy (SEM) and the corresponding EDS mapping of Cu₄TiSe₄.

(C) Temperature-dependent κ_L of Cu₄TiSe₄ obtained from the Boltzmann transport equation (BTE) calculations, MD simulations, and laser flash analysis (LFA) measurements. The green hollow triangles and square symbols represent the theoretical data taken from Chen et al.⁴⁷ The black and purple hollow symbols represent the experimental measurements reported in Koley et al.⁴⁶ and Lakshan et al.,⁵⁶ respectively. Error bars are shown but may be smaller than the symbol size.

long-wavelength phonons and leads to the collapse of short-wavelength phonons near the Brillouin zone boundary, highlighting the dominant role of disorder phonon scattering. The diffusion coefficient of Cu2 atoms is found to be much lower than the ion diffusion coefficient in superionic materials, resulting in a limited contribution from the convection process and an ultralow, weakly temperature-dependent κ_L of Cu₄TiSe₄.

RESULTS

Crystal structure and atomic dynamics of Cu₄TiSe₄ The crystal structure of Cu₄TiSe₄ over 181 K is characterized as the face-centered cubic arrangement (P 4̄ 3m space group) of fully occupied Ti, Se, and Cu1 atoms, while Cu2 atoms exhibit partial occupancy at five positions (one at 1a (0, 0, 0) with a site occupancy factor [SOF] of ~0.34 and four at 4e: x ≈ 0.83, y = z ≈ 0.17 with SOF ≈0.16),⁴⁶,⁵³ as shown in Figure 1B. We performed machine learning MTP-assisted MD simulations to calculate the per-atom-type mean square displacement (MSD), which is used to determine whether atoms exhibit hopping or diffusion behavior. As illustrated in Figures 1C and S2, the MSD of Cu2 atoms increases linearly with the simulation time, while the MSD of Cu1, Se, and Ti atoms fluctuates around a stable value range. It reveals the dynamic disorder behavior of Cu2 atoms within the rigid lattices composed of Cu1, Ti, and Se atoms, in agreement with the findings reported by Koley et al.⁴⁶ To better understand the dynamic disorder of Cu2 atoms, the atomic trajectories are shown in Figure 1D. At 200 K, Cu2 atoms demonstrate thermally excited hopping between adjacent sites. When the temperature increases to 300 K, Cu2 atoms can more easily move from the shallow potential well to the next equilibrium position, so the hopping range increases and becomes even more obvious at 400 K. The positive correlation between the dynamic disorder of Cu2 atoms and temperature is revealed by its increasing MSD and expanded hopping trajectory at higher temperatures, as shown in Figures 1C and 1D. We extracted the diffusion coefficient (D) of Cu2 atoms at 400 K from Einstein’s Brownian motion equation⁵⁴ and compared it with the diffusive atoms in typical superionic materials. Here, we noticed that the D of Cu2 atoms is much lower than that of liquid-like atoms in superionic materials, exhibiting an intermediate state between rigid lattice and superionics.

Thermal transport measurements and simulations We performed MD simulations with a machine-learning MTP to quantitatively analyze the underlying mechanisms driving the thermal transport in Cu₄TiSe₄ and further verified the results by experimental measurements. As shown in Figure 2A, neutron diffraction data are collected at 300 K to verify the structure of our pure polycrystalline sample by using the Rietveld refinement method. The atomic coordinates, together with their site occupancy and thermal displacement parameters, are listed in Table S1. Scanning electron microscopy (SEM) and energy-dispersive X-ray spectroscopy (EDS) are also used for characterization of the synthesized compound and analysis of elemental distribution, as shown in Figure 2B. Cu, Ti, and Se are all uniformly distributed, and there are no impurities observed in the measured area. Figure 2C shows the temperature-dependent κ_L obtained from the Green-Kubo equilibrium MD (GK-EMD) simulations based on the autocorrelation of heat flux and the sinusoidal approach to EMD (SAEMD) simulations based on the temporal evolution of the system temperature. Given the agreement between experimental and theoretical thermal conductivities and the relatively narrow temperature range, the effect of thermal expansion was not considered in this study. Our calculations of the κ_L are in reasonable agreement with the experimental measurements over the entire temperature range. Although the inclusion of

Newton 1, 100090, June 2, 2025 <page_number>3</page_number>

Page 5
<img>CellPress OPEN ACCESS</img> <img>Newton Article</img>

Table 1. Different components of the temperature-dependent κL calculated within GK formalism

T (K)	κV (W m-1 K-1)	κC (W m-1 K-1)	κVC (W m-1 K-1)
200	0.535	0.007	0.0003
250	0.464	0.009	-0.0247
300	0.381	0.010	0.0018
350	0.347	0.011	0.0142
400	0.360	0.014	-0.0152
κV, κC, and κVC represent atomic vibration, ion convection, and vibration-convection interaction contributions to the κL, respectively.

the four-phonon scattering process moves the calculated κL closer to the experimental value, the Peierls-Boltzmann transport approach based on the perturbation theory still gives a value of 2.2 W m-1 K-1 at 300 K, which is an overestimation of about 11 times compared to the experimental measurement. The better agreement between our calculated κL and the experimental measurements indicates that dynamic disorder scattering plays a dominant role in the thermal transport of Cu4TiSe4.

The contributions of atomic vibration (κV), convection (κC), and their coupling (κVC) to κL of Cu4TiSe4 have been further studied to unveil the thermal transport mechanism. The calculation details are provided in Note S3. As shown in Table 1, the κV accounts for more than 93% of the κL, suggesting that atomic vibrations around the equilibrium lattice sites are mainly responsible for the heat flux in Cu4TiSe4. Although the contribution of κC increases slightly under elevated temperature, the contributions of κC and κVC are insignificant. The κVC indicates coupled thermal transport between vibration and convection channels, where a negative value corresponds to the heat flux opposing the temperature gradient. In superionic materials, such as Cu7PSe6 and Ag8SnSe6, the κC and κVC contributed by the liquid-like atomic diffusion can reach more than 50% of the κL at 400 K. The low κC and κVC in Cu4TiSe4 are related to the dynamic disorder of Cu2 atoms that only hop between adjacent sites without forming a continuous liquid-like diffusion, evidenced by its low D (DCu2) of 9.13 × 10-7 cm2 S-1 at 400 K, which is significantly lower than the D of the diffusive atoms in the superionic materials. Therefore, the hopping of Cu2 atoms leads to effective dynamic disordered phonon scattering, strongly suppressing the lattice thermal transport. In superionic materials, κ can increase with temperature due to the growing contribution of the convective term; however, the lack of a continuous convection pathway in Cu4TiSe4 prevents this. This unique behavior, with negligible contribution of convective heat transport, warrants further investigation; e.g., phase change at high temperatures may influence the κ.

Anharmonic lattice dynamics

To reveal the effects of atomic hopping on the lattice dynamics of Cu4TiSe4, we adopt decomposed current correlation functions CT-L(q, t) to investigate the transverse and longitudinal phonon propagation modes along high-symmetry paths. The phonon spectra CT-L(q, ω) are obtained by Fourier transform of the real part of CT-L(q, t). From Figure 3, we find that most acoustic phonon modes can be clearly observed, and their frequencies match reasonably with the phonon dispersions obtained based on the quasi-harmonic approximation. However, some phonon modes dominated by the vibrations of Cu2 atoms, such as the transverse acoustic (TA) modes near the M point and the longitudinal acoustic (LA) modes near the R point, drastically diminish. Since the temperature is above the order-to-disorder reversible phase transition temperature (181 K) of Cu4TiSe4, we exclude the influence of the phase transition here. The well-defined TA and LA phonons show a clear increase in broadening as the temperature rises from 200 to 400 K, demonstrating enhanced phonon scattering. This partial breakdown of phonons demonstrates different anharmonic lattice dynamics from the

<img>Figure 3. Phonon dispersions and anharmonic lattice dynamics of Cu4TiSe4 (A) Calculated phonon dispersions of ordered Cu4TiSe4 using the finite-displacement method. The color map illustrates the contributions of Cu2 atomic vibration to the phonon modes, with the gradient from blue to red indicating a range from low to high contributions. The two insets depict the visualized atomic vibration at M and R points. (B-D) Transverse (red) and longitudinal (blue) Fourier-transformed current correlation functions CT-L(q, ω) of Cu4TiSe4 at different temperatures. The dashed curves are the dispersions taken from (A).</img>

<page_number>4</page_number> Newton 1, 100090, June 2, 2025

Page 6
Newton Article

<img>CellPress OPEN ACCESS</img>

A <img>Figure 4A: Fourier-transformed current correlation functions C(q, ω) near the zone center (q = [0, 0.11, 0]) showing transverse (red lines) and longitudinal (blue lines) modes at Γ-X, Γ-M, and Γ-R.</img> B <img>Figure 4B: Fourier-transformed current correlation functions C(q, ω) at the zone boundary (q = [0.125, 0.125, 0] and q = [0.5, 0.5, 0]) showing transverse (red lines) and longitudinal (blue lines) modes at Γ-X, Γ-M, and Γ-R.</img> C <img>Figure 4C: Comparison of phonon linewidths calculated from MD simulations with data obtained based on perturbation theory (PT). The plot shows linewidths (ps⁻¹) vs. frequency (THz) for PT-3ph (blue triangles), PT-4ph (green squares), and MD (red circles).</img>

Figure 4. Fourier-transformed current correlation functions and phonon linewidths of Cu₄TiSe₄ (A and B) Selected transverse (red lines) and longitudinal (blue lines) Fourier-transformed current correlation functions C(q, ω) (A) near the zone center and (B) at the zone boundary at 300 K. (C) Comparison of the mode-projected phonon linewidths of Cu₄TiSe₄ calculated from MD simulations with data obtained based on perturbation theory (PT).

PLEC model, where ultrafast dynamic disorder can completely suppress the TA phonons.

We present the phonon power spectra C(q, ω) near the center and at the boundary of the Brillouin zone along high-symmetry paths of Γ-X, Γ-M, and Γ-R in Figures 4A, 4B, and S9. The phonon modes near the center of the Brillouin zone display Lorentz-like line shapes. The characteristic peaks of TA and LA modes can still be seen on the Brillouin zone boundary at point X. However, the phonon modes at points M and R exhibit damped power spectra or fluctuations in a wide frequency range, indicating strong phonon scattering arising from the dominant contribution of Cu2 atoms. Despite the D of Cu2 atoms being much lower than that of Ag/Cu atoms in superionic materials such as AgCrSe₂, Ag₈SnSe₆, and Cu₇PSe₆, it is sufficient to disrupt their dominant phonon propagation patterns and induce strong dynamic disorder phonon scattering.

To further explore the scattering effect of the dynamic disorder of Cu2 atoms on phonons, we extract the linewidths of well-defined phonon modes by fitting the phonon power spectra with a Lorentz function, as shown in Figure 4C. It is observed that the phonon linewidths are much larger than those obtained from the perturbation theory at 300 K, suggesting that the phonon scattering induced by atomic hopping is strong. Although the hopping of Cu2 atoms is not fast enough to completely suppress the propagation of all phonon modes in Cu₄TiSe₄, they can strongly scatter phonons, suppressing the thermal transport.

order of Cu2 atoms results in collapse of Cu2-dominated phonon modes near the Brillouin zone boundary and broadens the linewidths of low-frequency phonons. The phonon scattering caused by dynamic disorder is critical for explaining the low κ_L of Cu₄TiSe₄. This work provides a comprehensive understanding of the relationship between atomic dynamics and phonon scattering, providing insights into the search for ultralow-κ_L materials and phonon engineering.

METHODS

Materials synthesis A total of 10.00 g of Cu (99.999%, wires), Ti (99.995%, pellets), and Se (99.99%, pellets) were weighed stoichiometrically in the nominal composition of Cu₄TiSe₄. The elements were sealed in a quartz tube under a vacuum of ~5 Pa and heated in a box furnace. After heating to 1253 K in 10 h, the tube was kept at this temperature for 120 h and then annealed at 973 K for 120 h and cooled down to room temperature in a furnace. The obtained ingots were ground into powder with an agate mortar and ball-milled in a SPEX SamplePrep 8000M mixer/mill for 4 h. The ball-milled powder was then sintered by rapid hot pressing in a graphite die under a uniaxial pressure of ~60 MPa at 853 K for 2 h.

Characterization and thermal conductivity measurements The time-of-flight powder neutron diffraction data were obtained on the multi-physics instrument at the China Spallation Neutron Source (Dongguan, China). An incident neutron beam with a wavelength band from 0.1 to 3 Å was used. The neutron flight path was 30 m, and diffraction data were collected by bank six at 130°. Refinement of neutron diffraction data was done using the GSAS II program. During the refinement, a constraint 4 × SOF (Cu2(4)) + SOF (Cu2(1a)) = 1 was applied to ensure that there are four Cu atoms in one unit cell.

The Linseis LFA1000 instrument was used for obtaining the thermal diffusivity α of the sintered sample, and the κ of

DISCUSSION

In conclusion, machine-learning MTP-assisted MD simulations were applied to investigate the anharmonic lattice dynamics and thermal transport of Cu₄TiSe₄. Our theoretical calculations reveal the thermally excited hopping behavior of Cu2 atoms in Cu₄TiSe₄, while the corresponding thermal convection term is negligible due to the lower D of Cu2 compared to the liquid-like atoms in superionic materials. We find that the dynamic dis-

Newton 1, 100090, June 2, 2025 <page_number>5</page_number>

Page 7
<img>CellPress OPEN ACCESS</img> <img>Newton Article</img>

Cu₄TiSe₄ was calculated with the equation κ = αρCp. In the equation, the specific heat Cp was estimated by Dulong-Petit law (Cp = 3n·R, where n and R are the number of atoms in the formula and the ideal gas constant, respectively), and the density ρ was measured via the Archimedes method by a Sartorius laboratory balance.

Construction of machine learning potential The first-generation machine-learning MTP was constructed from an initial training set of 400 configurations, of which the forces, energies, and stresses were calculated from density functional theory (see supplemental information for more details). These structures under different strains were generated using the finite-displacement method, phonon rattling,⁶² and ab initio MD (AIMD) simulations in the temperature range of 200–400 K based on a 3 × 3 × 3 ordered supercell (243 atoms) of Cu₄TiSe₄ (Figure 1A). Random atomic displacements of 0.1 Å were introduced based on a normal distribution, and the applied uniform triaxial strain range is from −3% to 3%. AIMD simulations were performed with a time step of 2 fs for 11 ps under the NVT (constant particle number N, volume V, and temperature T) ensemble, with the first 1 ps used to reach equilibrium and allow for the partial occupation of Cu2 atoms at the 1a and 4e sites. The subsequent 10 ps were sampled at a 100 fs interval to avoid correlated configurations. We used machine learning interatomic potential (MLIP) package⁵⁰ to construct the MTP, where the maximum level of 22 was chosen to define particular functional forms with default values of fitting weights for energies (We = 1), forces (Wf = 0.01), and stresses (Ws = 0.001). The cutoff radius and minimum radius were 8.5 and 2.06 Å, respectively, within which atoms were considered to be interactive. The MTPs were trained using active learning based on the D-based optimization strategy⁶³ with a selection threshold of 20 and a breaking threshold of 50. New configurations were dynamically selected via threshold-controlled active learning by performing independent MD simulations at 200, 300, and 400 K using the large-scale atomic/molecular massively parallel simulator (LAMMPS) package.⁶⁴ MD simulations were performed in the NVT ensemble with a duration of 0.5 ns and a time step of 1 fs. 539 new configurations were added to the final training set after six iterations until no more configurations were selected. We then conducted additional MD simulations at 200, 300, and 400 K to generate 135 configurations not included in the training set to construct an uncorrelated testing set. The cross-validation results are shown in Figure S1. It shows that the root-mean-square error (RMSE) of energies of the training (testing) set decreases from 0.337 (0.651) meV/atom for the initial MTP to 0.232 (0.349) meV/atom for the final MTP, and the RMSE of the atomic forces of the training and testing sets decreases to 0.021 and 0.017 eV/Å, respectively. This indicates that a well-trained MTP is obtained that can achieve high accuracy in interpolating potential energy surfaces between discrete quantum mechanical calculations.

MD simulations We used GK-EMD⁶⁵,⁶⁶ and SAEMD⁶⁷,⁶⁸ simulations to calculate the κL of Cu₄TiSe₄ from 200 to 400 K with the LAMMPS package and the machine-learning MTP. A 7 × 7 × 7 supercell (3087 atoms) was used for the GK-EMD simulations to minimize the finite size effect,⁶⁹ as shown in Figure S5. All simulated systems were first relaxed by minimizing the potential energy, followed by a 400 ps MD simulation under the NVT ensemble to reach equilibrium and the partial occupation of Cu2 atoms. MD simulations were then performed under the NVE (constant particle number N, volume V, and energy E without thermostat) ensemble for 0.6 ns to record heat current and calculate the κL within the GK formalism. The instant heat flux was calculated every 1.0 fs, and a correlation time of 20 ps was used to estimate the κL. A modified version of the MLIP package based on Fan’s many-body virial stress formulism⁷⁰ was employed, and a separate study regarding the modification and its implication to κL can be found in Tai et al.⁷¹ We took the average value in three directions as the κL of Cu₄TiSe₄, and five independent simulations were performed to obtain the average κL at each temperature. In the SAEMD simulations, a sinusoidal temperature gradient was applied along the direction of heat propagation under the NVT ensemble with a time step of 4 fs. Then, we monitored the temporal evolution of the mean temperature of the two halves within the NVE ensemble to evaluate the thermal diffusivity α, which was used to calculate the κL via the formula κL = αρCv (ρ and Cv represent density and the specific heat capacity at constant volume, respectively).⁶⁸ We used a 4 × 4 × 110 supercell (the cross-sectional area of the simulation box was 5.14 nm², and the length along the heat transport direction was 62.35 nm), which was tested to converge to calculate the κL of Cu₄TiSe₄ (Figure S8). Five independent simulations with different initial velocities were performed to obtain an average κL at each temperature.

RESOURCE AVAILABILITY

Lead contact Requests for further information, resources, and reagents should be directed to and will be fulfilled by the lead contact, Yue Chen (yuechen@hku.hk).

Materials availability This study did not produce new unique materials.

Data and code availability The source training and testing datasets related to the machine learning potential are available at https://zenodo.org/records/14646699. The additional data that support the findings of this study are available from the lead contact upon reasonable request.

ACKNOWLEDGMENTS R.C. and Wenzxuan Wang from HKU contributed equally to this work. We acknowledge the financial support from Guangdong Major Project of Basic and Applied Basic Research (2020B0301030001) and the Research Grants Council of Hong Kong (C7002-22Y, 17318122, and C6020-22GF). The neutron diffraction experiment was performed at the CSNS. The authors are grateful for the research computing facilities offered by ITS, HKU.

AUTHOR CONTRIBUTIONS R.C., C.W., and Y.C. conceived the idea and designed the project. R.C., S.T.T., and N.O. performed the calculations. Wenzxuan Wang, Wei Wang, X.W., and Q. L. performed the experiments and analysis. R.C., Wenzxuan Wang, C.W., and Y.C. wrote the paper.

<page_number>6</page_number> Newton 1, 100090, June 2, 2025

Page 8
Newton Article

<img>CellPress OPEN ACCESS</img>

DECLARATION OF INTERESTS

The authors declare no competing interests.

SUPPLEMENTAL INFORMATION

Supplemental information can be found online at https://doi.org/10.1016/j.newton.2025.100090.

Received: November 28, 2024 Revised: February 16, 2025 Accepted: April 3, 2025 Published: April 28, 2025

REFERENCES

Padture, N.P., Gell, M., and Jordan, E.H. (2002). Thermal barrier coatings for gas-turbine engine applications. Science 296, 280–284.
Li, F., Zhou, L., Liu, J.X., Liang, Y., and Zhang, G.J. (2019). High-entropy pyrochlores with low thermal conductivity for thermal barrier coating materials. J. Adv. Ceram. 8, 576–582.
Shi, X.L., Zou, J., and Chen, Z.G. (2020). Advanced thermoelectric design: from materials and structures to devices. Chem. Rev. 120, 7399–7515.
Yang, S., Qiu, P., Chen, L., and Shi, X. (2021). Recent developments in flexible thermoelectric devices. Small Sci. 1, 2100005.
Jia, B., Wu, D., Xie, L., Wang, W., Yu, T., Li, S., Wang, Y., Xu, Y., Jiang, B., Chen, Z., et al. (2024). Pseudo-nanostructure and trapped-hole release induce high thermoelectric performance in PbTe. Science 384, 81–86.
Tritt, T.M. (2005). Thermal Conductivity: Theory, Properties, and Applications (Springer Science & Business Media).
Knoop, F., Purcell, T.A.R., Scheffler, M., and Carbogno, C. (2023). Anharmonicity in thermal insulators: An analysis from first principles. Phys. Rev. Lett. 130, 236301.
Hong, J., and Delaire, O. (2019). Phase transition and anharmonicity in SnSe. Mater. Today Phys. 10, 100093.
Nielsen, M.D., Ozolins, V., and Heremans, J.P. (2013). Lone pair electrons minimize lattice thermal conductivity. Energy Environ. Sci. 6, 570–578.
Skoug, E.J., and Morelli, D.T. (2011). Role of lone-pair electrons in producing minimum thermal conductivity in nitrogen-group chalcogenide compounds. Phys. Rev. Lett. 107, 235901.
Jana, M.K., Pal, K., Waghmare, U.V., and Biswas, K. (2016). The origin of ultralow thermal conductivity in InTe: Lone pair-induced anharmonic rattling. Angew. Chem. Int. Ed. 55, 7792–7796.
Shen, X., Pal, K., Acharyya, P., Raveau, B., Boullay, P., Lebedev, O.I., Prestipino, C., Fujii, S., Yang, C.C., Tsao, I.Y., et al. (2024). Lone pair induced 1d character and weak cation–anion interactions: Two ingredients for low thermal conductivity in mixed-anion metal chalcohalide CuBiSCl₂. J. Am. Chem. Soc. 146, 29072–29083.
Sato, N., Kuroda, N., Nakamura, S., Katsura, Y., Kanazawa, I., Kimura, K., and Mori, T. (2021). Bonding heterogeneity in mixed-anion compounds realizes ultralow lattice thermal conductivity. J. Mater. Chem. A 9, 22660–22669.
Mark, J., Zhang, W., Maeda, K., Yamamoto, T., Kageyama, H., and Mori, T. (2023). Ultralow thermal conductivity in the mixed-anion solid solution Sn₂SbS₂₋ₓSeₓI₃. J. Mater. Chem. A 11, 10213–10221.
Lee, S., Esfarjani, K., Luo, T., Zhou, J., Tian, Z., and Chen, G. (2014). Resonant bonding leads to low lattice thermal conductivity. Nat. Commun. 5, 3525.
Qin, G., Zhang, X., Yue, S.Y., Qin, Z., Wang, H., Han, Y., and Hu, M. (2016). Resonant bonding driven giant phonon anharmonicity and low thermal conductivity of phosphorene. Phys. Rev. B 94, 165445.
Zhang, W., Sato, N., Tobita, K., Kimura, K., and Mori, T. (2020). Unusual lattice dynamics and anisotropic thermal conductivity in In₂Te₅ due to a layered structure and planar-coordinated Te-chains. Chem. Mater. 32, 5335–5342.
Lin, H., Tan, G., Shen, J.N., Hao, S., Wu, L.M., Calta, N., Malliakas, C., Wang, S., Uher, C., Wolverton, C., and Kanatzidis, M.G. (2016). Concerted rattling in CsAg₅Te₃ leading to ultralow thermal conductivity and high thermoelectric performance. Angew. Chem. Int. Ed. 55, 11431–11436.
Li, W., and Mingo, N. (2014). Thermal conductivity of fully filled skutterudites: Role of the filler. Phys. Rev. B 89, 184304.
Mukhopadhyay, S., Parker, D.S., Sales, B.C., Puretzky, A.A., McGuire, M. A., and Lindsay, L. (2018). Two-channel model for ultralow thermal conductivity of crystalline Tl₃VSe₄. Science 360, 1455–1458.
Jana, M.K., Pal, K., Warankar, A., Mandal, P., Waghmare, U.V., and Biswas, K. (2017). Intrinsic rattler-induced low thermal conductivity in Zintl type TlInTe₂. J. Am. Chem. Soc. 139, 4350–4353.
Wang, C., Wang, Q., Zhang, Q., Chen, C., and Chen, Y. (2022). Intrinsic zn vacancies-induced wavelike tunneling of phonons and ultralow lattice thermal conductivity in zintl phase Sr₂ZnSb₂. Chem. Mater. 34, 7837–7844.
Zhao, M., and Pan, W. (2013). Effect of lattice defects on thermal conductivity of Ti-doped, Y₂O₃-stabilized ZrO₂. Acta Mater. 61, 5496–5503.
Serhiienko, I., Novitskii, A., Garmroudi, F., Kolesnikov, E., Chernyshova, E., Sviridova, T., Bogach, A., Voronin, A., Nguyen, H.D., Kawamoto, N., et al. (2024). Record-high thermoelectric performance in Al-doped ZnO via anderson localization of band edge states. Adv. Sci. 11, 2309291.
Kim, S.I., Lee, K.H., Mun, H.A., Kim, H.S., Hwang, S.W., Roh, J.W., Yang, D.J., Shin, W.H., Li, X.S., Lee, Y.H., et al. (2015). Dense dislocation arrays embedded in grain boundaries for high-performance bulk thermoelectrics. Science 348, 109–114.
Liu, Y., Zhou, M., and He, J. (2016). Towards higher thermoelectric performance of Bi₂Te₃ via defect engineering. Scr. Mater. 111, 39–43.
Wu, C.W., Ren, X., Xie, G., Zhou, W.X., Zhang, G., and Chen, K.Q. (2022). Enhanced high-temperature thermoelectric performance by strain engineering in BiOCl. Phys. Rev. Appl. 18, 014053.
Li, X., Maute, K., Dunn, M.L., and Yang, R. (2010). Strain effects on the thermal conductivity of nanostructures. Phys. Rev. B 81, 245318.
Cheng, R., Zeng, Z., Wang, C., Ouyang, N., and Chen, Y. (2024). Impact of strain-insensitive low-frequency phonon modes on lattice thermal transport in A₂XB₆-type perovskites. Phys. Rev. B 109, 054305.
Liu, H., Shi, X., Xu, F., Zhang, L., Zhang, W., Chen, L., Li, Q., Uher, C., Day, T., and Snyder, G.J. (2012). Copper ion liquid-like thermoelectrics. Nat. Mater. 11, 422–425.
Niedziela, J.L., Bansal, D., May, A.F., Ding, J., Lanigan-Atkins, T., Ehlers, G., Abernathy, D.L., Said, A., and Delaire, O. (2019). Selective breakdown of phonon quasiparticles across superionic transition in CuCrSe₂. Nat. Phys. 15, 73–78.
Qiu, W., Xi, L., Wei, P., Ke, X., Yang, J., and Zhang, W. (2014). Part-crystalline part-liquid state and rattling-like thermal damping in materials with chemical-bond hierarchy. Proc. Natl. Acad. Sci. 111, 15031–15035.
Wang, C., Wu, Y., Pei, Y., and Chen, Y. (2020). Dynamic disorder phonon scattering mediated by Cu atomic hopping and diffusion in Cu₃SbSe₃. npj Comput. Mater. 6, 155.
Rettie, A.J.E., Malliakas, C.D., Botana, A.S., Hodges, J.M., Han, F., Huang, R., Chung, D.Y., and Kanatzidis, M.G. (2018). Ag₂Se to KAg₃Se₂: suppressing order-disorder transitions via reduced dimensionality. J. Am. Chem. Soc. 140, 9193–9202.
Rettie, A.J.E., Ding, J., Zhou, X., Johnson, M.J., Malliakas, C.D., Osti, N.C., Chung, D.Y., Osborn, R., Delaire, O., Rosenkranz, S., and Kanatzidis, M.G. (2021). A two-dimensional type I superionic conductor. Nat. Mater. 20, 1683–1688.
Wang, C., Cheng, R., and Chen, Y. (2023). Theoretical evaluation of the persistence of transverse phonons across a liquid-like transition in superionic conductor KAg₃Se₂. Chem. Mater. 35, 1780–1787.
Newton 1, 100090, June 2, 2025 <page_number>7</page_number>

Page 9
<img>CellPress OPEN ACCESS</img> <img>Newton Article</img>

Li, B., Wang, H., Kawakita, Y., Zhang, Q., Feygenson, M., Yu, H.L., Wu, D., Ohara, K., Kikuchi, T., Shibata, K., et al. (2018). Liquid-like thermal conduction in intercalated layered crystalline solids. Nat. Mater. 17, 226–230.
Wang, C., and Chen, Y. (2023). Anisotropic phonon scattering and thermal transport property induced by the liquid-like behavior of AgCrSe₂. Nano Lett. 23, 3524–3531.
Gupta, M.K., Ding, J., Bansal, D., Abernathy, D.L., Ehlers, G., Osti, N.C., Zeier, W.G., and Delaire, O. (2022). Strongly anharmonic phonons and their role in superionic diffusion and ultralow thermal conductivity of Cu₇PSe₆. Adv. Energy Mater. 12, 2200596.
Ishiwata, S., Shiomi, Y., Lee, J.S., Bahramy, M.S., Suzuki, T., Uchida, M., Arita, R., Taguchi, Y., and Tokura, Y. (2013). Extremely high electron mobility in a phonon-glass semimetal. Nat. Mater. 12, 512–517.
Roychowdhury, S., Jana, M.K., Pan, J., Guin, S.N., Sanyal, D., Waghamare, U.V., and Biswas, K. (2018). Soft phonon modes leading to ultralow thermal conductivity and high thermoelectric performance in AgCuTe. Angew. Chem. 130, 4107–4111.
Ren, Q., Gupta, M.K., Jin, M., Ding, J., Wu, J., Chen, Z., Lin, S., Fabelo, O., Rodríguez-Velamazán, J.A., Kofu, M., et al. (2023). Extreme phonon anharmonicity underpins superionic diffusion and ultralow thermal conductivity in argyrodite Ag₈SnSe₆. Nat. Mater. 22, 999–1006.
Wu, B., Zhou, Y., and Hu, M. (2018). Two-channel thermal transport in ordered-disordered superionic Ag₂Te and its traditionally contradictory enhancement by nanotwin boundary. J. Phys. Chem. Lett. 9, 5704–5709.
Zhou, Y., Xiong, S., Zhang, X., Volz, S., and Hu, M. (2018). Thermal transport crossover from crystalline to partial-crystalline partial-liquid state. Nat. Commun. 9, 4712.
Zhou, Y., and Volz, S. (2021). Thermal transfer in amorphous superionic Li₂S. Phys. Rev. B 103, 224204.
Koley, B., Lakshan, A., Raghuvanshi, P.R., Singh, C., Bhattacharya, A., and Jana, P.P. (2021). Ultralow lattice thermal conductivity at room temperature in Cu₄TiSe₄. Angew. Chem. Int. Ed. 60, 9106–9113.
Chen, X.K., Zhang, E.M., Wu, D., and Chen, K.Q. (2023). Strain-induced medium-temperature thermoelectric performance of Cu₄TiSe₄: The role of four-phonon scattering. Phys. Rev. Appl. 19, 044052.
Zhang, T., Yu, T., Ning, S., Zhang, Z., Qi, N., Jiang, M., and Chen, Z. (2023). Extremely low lattice thermal conductivity leading to superior thermoelectric performance in Cu₄TiSe₄. ACS Appl. Mater. Interfaces 15, 32453–32462.
Liu, Z., Zhang, W., Gao, W., and Mori, T. (2021). A material catalogue with glass-like thermal conductivity mediated by crystallographic occupancy for thermoelectric application. Energy Environ. Sci. 14, 3579–3587.
Novikov, I.S., Gubaev, K., Podryabinkin, E.V., and Shapeev, A.V. (2021). The MLIP package: moment tensor potentials with MPI and active learning. Mach. Learn, Sci. Technol. 2, 025002.
Momma, K., and Izumi, F. (2008). VESTA: A three-dimensional visualization system for electronic and structural analysis. J. Appl. Crystallogr. 41, 653–658.
Nazrul Islam, S.M.K., Mayank, P., Ouyang, Y., Chen, J., Sagotra, A.K., Li, M., Cortie, M.B., Mole, R., Cazorla, C., Yu, D., et al. (2021). Copper diffusion rates and hopping pathways in superionic Cu₂Se. Acta Mater. 215, 117026.
Koley, B., Lakshan, A., and Jana, P.P. (2021). Temperature-induced phase transition in Cu₄TiSe₄. Eur. J. Inorg. Chem. 2021, 5052–5059.
Einstein, A. (1905). On the motion of small particles suspended in liquids at rest required by the molecular-kinetic theory of heat. Ann. Phys. 17, 208.
Ziman, J.M. (2001). Electrons and Phonons: The Theory of Transport Phenomena in Solids (New York: Oxford University Press).
Lakshan, A., Koley, B., Buxi, K., Raghuvanshi, P.R., Nuss, J., Bhattacharya, A., Chatterjee, R., Roy, A., and Jana, P.P. (2024). Disorder-mediated structural transformation in the Cu₄TiSe₄₋ₓSₓ (0 ≤ x ≤ 4) system and its effects on the thermal transport property. Chem. Mater. 36, 5741–5752.
Hardy, R.J. (1963). Energy-flux operator for a lattice. Phys. Rev. 132, 168–177.
Henry, A., and Chen, G. (2009). Anomalous heat conduction in polyethylene chains: Theory and molecular dynamics simulations. Phys. Rev. B 79, 144305.
Fransson, E., Slabanja, M., Erhart, P., and Wahnström, G. (2021). DYNASOR—a tool for extracting dynamical structure factors and current correlation functions from molecular dynamics simulations. Adv. Theory Simul. 4, 2000240.
Frenkel, J. (1947). Kinetic Theory of Liquids (New York: Oxford University Press).
Toby, B.H., and Von Dreele, R.B. (2013). GSAS-II: the genesis of a modern open-source all purpose crystallography software package. J. Appl. Crystallogr. 46, 544–549.
Eriksson, F., Fransson, E., and Erhart, P. (2019). The hiphive package for the extraction of high-order force constants by machine learning. Adv. Theory Simul. 2, 1800184.
Podryabinkin, E.V., and Shapeev, A.V. (2017). Active learning of linearly parametrized interatomic potentials. Comput. Mater. Sci. 140, 171–180.
Plimpton, S. (1995). Fast parallel algorithms for short-range molecular dynamics. J. Comput. Phys. 117, 1–19.
Kubo, R. (1986). Brownian motion and nonequilibrium statistical mechanics. Science 233, 330–334.
Kubo, R. (1957). Statistical-mechanical theory of irreversible processes. I. general theory and simple applications to magnetic and conduction problems. J. Phys. Soc. Jpn. 12, 570–586.
Lampin, E., Palla, P.L., Francioso, P.A., and Cleri, F. (2013). Thermal conductivity from approach-to-equilibrium molecular dynamics. J. Appl. Phys. 114, 033525.
Puligheddu, M., Gygi, F., and Galli, G. (2017). First-principles simulations of heat transport. Phys. Rev. Mater. 1, 060802.
Schelling, P.K., Phillpot, S.R., and Keblinski, P. (2002). Comparison of atomic-level simulation methods for computing thermal conductivity. Phys. Rev. B 65, 144306.
Fan, Z., Pereira, L.F.C., Wang, H.Q., Zheng, J.C., Donadio, D., and Harju, A. (2015). Force and heat current formulas for many-body potentials in molecular dynamics simulations with applications to thermal conductivity calculations. Phys. Rev. B 92, 094301.
Tai, S.T., Wang, C., Cheng, R., and Chen, Y. (2025). Revisiting many-body interaction heat current and thermal conductivity calculations using the moment tensor potential/LAMMPS interface. J. Chem. Theory Comput. 21, 3649–3657.
<page_number>8</page_number> Newton 1, 100090, June 2, 2025