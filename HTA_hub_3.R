pacman::p_load(shiny, shinydashboard, shinyjqui, sortable, plotly, BCEA, ggplot2, purrr, data.table, shinyjs, knitr, shinycssloaders, hesim, magrittr, fastGHQuad, mstate, dplyr, wakefield, tidyverse)

# library(shiny)
# library(shinydashboard)
# library(plotly)
# library(BCEA)
# library(ggplot2)
# library(purrr)
# library(data.table)
# library(shinyjs)
# library(knitr)
# library(shinycssloaders)
# library(hesim)
# library(magrittr)
# library(sortable)
# library(shinyjqui)
# library(dplyr)


#_______________________________________________________________________________________________________________________
header<-dashboardHeader(title = HTML(paste0("<h2>
                                              <b >
                                                <p style=\"font-family: 'Times New Roman', Times, serif;\">  HTA Hub </p>
                                              </b>
                                            </h2>")))
#_______________________________________________________________________________________________________________________


sidebar<-dashboardSidebar( 
  sidebarMenu(id="sidebarid",
              menuItem(text ="Welcome & Overview",tabName = "welcome_tab",icon=icon("house"), startExpanded = T,
                       menuSubItem(text="Economic Evaluation",tabName = "economic_evaluation",icon=icon("chart-line")),
                       menuSubItem(text="About CEA",tabName = "cost_effectiveness",icon=icon("scale-unbalanced")),
                       menuSubItem(text="About CBA",tabName = "cost_benefit",icon=icon("hand-holding-dollar")),
                       menuSubItem(text="About COI",tabName = "cost_of_illness",icon=icon("hospital-user"))
                       #                            menuSubItem(text="Budget Impact Analysis",tabName = "budget_impact",icon=icon("sack-dollar"))
              ),
              menuItem(text ="Cost-Effectiveness Analysis",tabName = "cost_effectiveness_tab",icon=icon("scale-unbalanced")),
              menuItem(text ="Cost-Benefit Analysis",tabName = "cost_benefit_tab",icon=icon("hand-holding-dollar")),
              menuItem(text ="Cost of Illness Analysis",tabName = "cost_of_illness_tab",icon=icon("hospital-user")),
              #              menuItem(text ="Budget Impact Analysis",tabName = "budget_impact_tab",icon=icon("sack-dollar")),
              #menuItem(text ="Video Tutorial",tabName = "video_tab",icon=icon("gear")),
              
              
              conditionalPanel('input.sidebarid != "welcome_tab"', hr()),
              conditionalPanel('input.sidebarid == "cost_effectiveness_tab"',
                               radioButtons(inputId = "data_filter",label = "Select a dataset",choices = c("Smoking","Demo_dataset","Upload_dataset")),
                               conditionalPanel('input.data_filter == "Upload_dataset"',
                                                fileInput("file1", "Choose CSV File", accept = c("text/csv", "text/comma-separated-values, .csv")))
              ),
              conditionalPanel('input.sidebarid == "cost_benefit_tab"',
                               radioButtons(inputId = "data_filter1",label = "Dataset",choices = c("Patient_treatment_data", "Upload_Dataset")),
                               conditionalPanel('input.data_filter1 == "Upload_Dataset"',
                                                fileInput("file1", "Choose CSV File", accept = c("text/csv", "text/comma-separated-values, .csv")))
              ),
              conditionalPanel('input.sidebarid == "cost_of_illness_tab"',
                               radioButtons(inputId = "data_filter2",label = "Dataset",choices = c("Insurance_data", "Upload_the_Dataset")),
                               conditionalPanel('input.data_filter2 == "Upload_the_Dataset"',
                                                fileInput("file1", "Choose CSV File", accept = c("text/csv", "text/comma-separated-values, .csv")))
              )
              
              
              
              
              
  )
)

#_______________________________________________________________________________________________________________________



body<-dashboardBody(
  
  #HTML(paste0("<h1><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Welcome and Overview</p></b></h1>")),
  tabItems(
    tabItem(tabName = "economic_evaluation",
            HTML(paste0("<h1><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Welcome & Overview</p></b></h1>")),
            
            HTML("<h3><b><p style=\"font-family: 'Times New Roman', Times, serif;\"> Economic Evaluation: Health Economic studies </p></b></h3>
            
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Public health professionals can use economic evaluation to identify, measure, value, and compare
                  the costs and consequences of different public health interventions. Allocating resources and implementing these interventions whether policies or programs require
                  an understanding of the relationships between resources used and health outcomes achieved by the program or intervention<sup>[1]</sup>.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Economic evaluation can consider both resources used and health outcomes achieved simultaneously.
                  It can also be useful in supporting decision-making when resources are limited.</p><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Methods of Economic evaluation </p></b></h4>
                  
                  <p style=\"padding: 4px; border: 2px solid black;display: inline-block; width:600px\"><img src=\"cea.png\" width=\"30\" height=\"30\"><b> Cost-effectiveness Analysis:</b> How do costs compare to outcomes?</p><br>
                  
                  <p style=\"padding: 4px; border: 2px solid black;display: inline-block; width:600px\"><img src=\"cba.png\" width=\"30\" height=\"30\"><b> Cost-benefit Analysis:</b> How do costs compare to benefits?</p><br>
                  
                  <p style=\"padding: 4px; border: 2px solid black;display: inline-block; width:600px\"><img src=\"coi.png\" width=\"30\" height=\"30\"><b> Cost of Illness Analysis:</b> What is the economic burden of the condition?</p><br>
                  
                  <p style=\"padding: 4px; border: 2px solid black;display: inline-block; width:600px\"><img src=\"budget.png\" width=\"30\" height=\"30\"><b> Budget Impact Analysis:</b>What is the financial consequences of adopting a new intervention?</p><br><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What to use it for </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Economic evaluation can be used to inform decisions about the economic impact and relative value for money of digital health products. It can tell you whether 
                  differences in costs between your product and competing alternatives can be justified in terms of health and non-health benefits<sup>[2]</sup>.</p><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Planning an economic evaluation </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">There are some important methodological aspects that you should consider when undertaking an economic evaluation.</p><br>
                  
                  <h5><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Choosing a comparison </p></b></h5>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Choosing what to compare your product to (the comparator) is important. You should consider:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>what your product intends to displace or compete with</li>

                  <li>what evidence is available on costs and effects</li></ul>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\"> Relevant comparators could be:</p>

                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>an alternative way of implementing your product</li>
                  
                  <li>a competing product</li>
                  
                  <li>existing technology, before your product became available</li>

                  <li>not using your product (often known as ‘do nothing’)</li></ul><br>
                  
                  <h5><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Deciding the study perspective </p></b></h5>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">The study perspective is the point of view you will take for the economic evaluation. This is important because it determines which costs and effects are 
                  relevant to your analysis and need to be captured. For example, the reduction of psychiatric hospital beds might seem cost-effective from the perspective of the NHS but less so from that of society as a whole, 
                  including patients’ or carers’ perspectives.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">A societal perspective helps detect cost shifting between different sectors, for example formal and informal care, or health and economy sectors.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Typical viewpoints are those of:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>the patient</li>
                  
                  <li>the healthcare provider – for example, a hospital</li>
                  
                  <li>the healthcare system</li>

                  <li>society</li></ul>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">A societal perspective considers all relevant costs, whoever pays for them. This includes non-healthcare costs, such as productivity losses, informal 
                  care, and out-of-pocket expenses. This perspective also includes benefits beyond those to the patient, such as benefits to caregivers.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">You may need a broader societal perspective, for example if:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>the costs associated with your digital product are borne by different parties, such as the NHS and the patient</li>
                  
                  <li>your digital product is likely to provide important non-health benefits, such as productivity gains and social inclusion</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Measuring costs and effects </p></b></h4>
                  
                  <h5><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Costs </p></b></h5>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">You can calculate costs by identifying, quantifying and valuing resource use associated with the interventions you’re comparing.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">To identify relevant resource use, consider how your digital product impacts on the patient, provider and healthcare system. This 
                  emphasises the importance of considering a broader study perspective that includes resource use beyond costs to the NHS. For example, your digital product might impact on patients’ productivity and travel costs.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">When identifying relevant resource use, also think about the implications of providing your product for general use. For example, consider whether:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>to include resources related to product development (these would usually be excluded if, for example, your product was a modification of an existing one)</li>
                  
                  <li>your product will be free or users will pay for it</li>

                  <li>there will be any resource implications to scaling up your product (for example, maintenance resources)</li></ul>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">After you have identified all resource use, you need to plan how to measure those resources consumed by the patient, healthcare system or other party as 
                  a result of using your digital product. This data should be based on physical measures, such as the time spent facilitating your product. You might be able to get this data from:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>medical records (routinely collected data)</li>
                  
                  <li>patient-completed diaries</li>
                  
                  <li>prospective patient forms</li>

                  <li>data collected through websites or mobile applications – for example, they might record how many times patients or health professionals interacted with your product or the time they spent with it</li></ul>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">To work out costs from resource use data, apply appropriate unit costs. Unit costs are the cost per unit of an item of resource use, such as the hourly 
                  wage of a health professional that will be applied to the time spent interacting with your product.</p>
                  
                  <h5><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Effects </p></b></h5>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">The measurement of effects should relate to the purpose of your digital product. You may want to use a broader study perspective, so that the economic study 
                  can include both health and non-health effects. Health-related effects might be:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>disease-specific, for example lowering cholesterol levels</li>

                  <li>generic, such as improving health-related quality of life</li></ul>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Non-health effects might include:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>improvements to the way patients interact with the health system</li>
                  
                  <li>improved patient empowerment</li>

                  <li>greater social inclusion</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Incremental approach </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">An incremental approach involves estimating the incremental (or additional) cost and incremental effect of an intervention 
                  compared to alternative options. It can tell you the marginal cost of producing one additional unit of benefit of your product compared to alternative options. This is crucial when 
                  comparing alternative digital products competing for available resources. It allows the decision maker to efficiently allocate resources by providing digital products that have the lowest cost per unit of benefit gained.</p>
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  <br><br><br>
                  
                  <h4><b><p style=\"font-family: 'Times New Roman', Times, serif;\">References</p></b></h4>
                  
                  <ol style=\"font-family: 'Times New Roman', Times, serif;\">
                  
                  <li> <p><a href='https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html'>
                 CDC. Cost-Effectiveness Analysis | POLARIS | ADP-Policy | CDC [Internet]. www.cdc.gov. 2021. Available from: https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html</a>
                 </p> </li>
                 
                 <li> <p><a href='https://www.gov.uk/guidance/economic-evaluation-health-economic-studies'>
                 Office for Health Improvement and Disparities. Economic evaluation: health economic studies [Internet]. GOV.UK. 2020. Available from: https://www.gov.uk/guidance/economic-evaluation-health-economic-studies</a>
                 </p> </li></ol>")
            
            
    ),
    #_______________________________________________________________________________________________________________________
    
    
    tabItem(tabName = "cost_effectiveness",
            HTML(paste0("<h1><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Welcome & Overview</p></b></h1>")),
            HTML("<h3><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cost-effectiveness Analysis </p></b></h3>
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost-effectiveness analysis is a way to examine both the costs and health outcomes of 
                  one or more interventions. It compares an intervention to another intervention (or the status quo) by estimating how much it costs to gain a unit
                  of a health outcome, like a life year gained or a death prevented<sup>[1]</sup>.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Typically the CEA is expressed in terms of a ratio where the denominator is a gain in health 
                  from a measure (years of life, premature births averted, sight-years gained) and the numerator is the cost associated with the health gain. The most 
                  commonly used outcome measure is quality-adjusted life years (QALY).</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost effectiveness analysis (CEA) is one type of economic evaluation that compares the costs 
                  and effects of alternative health interventions. CEA focuses on assessing the intervention’s impact on clinical measures, unlike other types of economic 
                  evaluation that consider broader effects<sup>[2]</sup>.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">CEA measures effects in physical units of health outcomes. These are typically clinical outcomes,
                  such as blood pressure and cardiovascular events. CEA enables you to compare the costs and health effects of your digital product with alternatives, 
                  as long as the effects of the different interventions are measured in the same units.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">CEA results can help decision-makers who want to achieve a specific health objective. For example,
                  a CEA study can help a health commissioner decide which mobile app to invest in to manage the most patients with type-2 diabetes by identifying the app that 
                  provides the lowest cost per managed diabetes case.</p><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What inputs are included? </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>Net cost is the intervention costs minus averted medical and productivity costs.</li>
                  
                  <li>Changes in health outcomes are outcomes with the intervention in place minus outcomes without the intervention in place.</li>
                  
                  <li>Examples of health outcomes include heart attacks and deaths from heart disease.</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What output does a cost-effectiveness analysis provide? </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>CEA provides information on health and cost impacts of an intervention compared to an 
                  alternative intervention (or the status quo). If the net costs of an intervention are positive (which means a more effective intervention is more costly),
                  the results are presented as a cost-effectiveness ratio. A cost-effectiveness ratio is the net cost divided by changes in health outcomes. Examples include 
                  cost per case of disease prevented or cost per death averted. However, if the net costs are negative (which means a more effective intervention is less costly), 
                  the results are reported as net cost savings<sup>[1]</sup>.</li>
                  </ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> How can information from a CEA be useful for decision makers? </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>CEA can be useful in comparing the health and cost impacts of different interventions affecting 
                  the same health outcome. It can also be useful for understanding how much an intervention may cost (per unit of health gained) compared to an alternative intervention. 
                  For example, a decision maker might ﬁnd it useful to know if an intervention is cost saving, and if not how much more would it cost to implement it compared to a less 
                  effective intervention.</li>
                  </ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cost-effectiveness plane </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li> The cost-effectiveness plane plots the incremental effectiveness of a treatment 
                  strategy (relative to a comparator) against the incremental cost of the treatment strategy. The plot is useful because it demonstrates both the uncertainty and
                  the magnitude of the estimates. Each point on the plot is from a particular random draw from the PSA<sup>[3]</sup>.</li>
                  </ul><br>
                  
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cost-effectiveness acceptability curve </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li> The cost-effectiveness acceptability curve (CEAC) is a graph summarising
                  the impact of uncertainty on the result of an economic evaluation, frequently expressed as an ICER (incremental cost-effectiveness ratio) 
                  in relation to possible values of the cost-effectiveness threshold. The graph plots a range of cost-effectiveness thresholds on the 
                  horizontal axis against the probability that the intervention will be cost-effective at that threshold on the vertical axis. 
                  It can usually be drawn directly from the (stored) results of a probabilistic sensitivity analysis. The CEAC helps the decision-maker
                  to understand the uncertainty associated with making a particular decision to approve or reject a new heath technology.<sup>[4]</sup>.</li>
                  </ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What to use it for </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Use a cost effectiveness analysis when:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>you want to assess the value for money of your digital product compared to alternative options
                  using the same unit of effect, usually to do with a particular disease</li>
                  
                  <li>the benefits of using your product are mostly health-related</li>
                  
                  <li>clinical measures are most appropriate to capture the health benefits from using your product</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Pros</p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Advantages of CEA include:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>clinical outcomes are relatively straightforward to measure, 
                  particularly if the economic evaluation is linked to a clinical trial</li>

                  <li>it gives you an assessment of alternative options based on disease-specific measures of health effects</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cons</p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Drawbacks of CEA include:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>it cannot inform broader resource allocation 
                  decisions across different diseases because health benefits will often be measured in different units (different clinical outcomes)</li></ul><br>
                  
                  
                  
                  
                  
                  <br><br>
                  
                  <h4><b><p style=\"font-family: 'Times New Roman', Times, serif;\">References</p></b></h4>
                  
                  <ol style=\"font-family: 'Times New Roman', Times, serif;\">
                  
                  <li> <p><a href='https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html'>
                  CDC. Cost-Effectiveness Analysis | POLARIS | ADP-Policy | CDC [Internet]. www.cdc.gov. 2021. Available from: https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html</a></p> </li>
                  
                  <li> <p><a href='https://www.gov.uk/guidance/economic-evaluation-health-economic-studies'>
                 Office for Health Improvement and Disparities. Economic evaluation: health economic studies [Internet]. GOV.UK. 2020. Available from: https://www.gov.uk/guidance/economic-evaluation-health-economic-studies</a>
                 </p> </li>
                  
                  <li> <p><a href='https://cran.r-project.org/web/packages/hesim/vignettes/cea.html'>
                  Incremental cost-effectiveness ratio (ICER) [Internet]. R-Packages. [cited 2023 Dec 20]. Available from: https://cran.r-project.org/web/packages/hesim/vignettes/cea.html
                 </a></p> </li>
                 
                 <li> <p><a href='https://yhec.co.uk/glossary/cost-effectiveness-acceptability-curve-ceac/#:~:text=The%20cost%2Deffectiveness%20acceptability%20curve,of%20the%20cost%2Deffectiveness%20threshold.'>
                  Cost-Effectiveness Acceptability Curve (CEAC) [Internet]. YHEC - York Health Economics Consortium. [cited 2024 Jan 22]. 
                 </a></p> </li></ol>")
            
            
    ),
    
    #_______________________________________________________________________________________________________________________
    
    
    
    tabItem(tabName = "cost_benefit",
            HTML(paste0("<h1><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Welcome & Overview</p></b></h1>")),
            HTML("<h3><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cost-Benefit Analysis </p></b></h3>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost-benefit analysis is a way to compare the costs 
                  and benefits of an intervention, where both are expressed in monetary units<sup>[1]</sup>.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Both CBA and cost-effectiveness analysis (CEA) include health outcomes. 
                  However, CBA places a monetary value on health outcomes so that both costs and benefits are in monetary units (such as dollars).</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost benefit analysis (CBA) is one economic evaluation tool to compare the costs 
                  and effects of alternative interventions. CBA measures both costs and effects of interventions in monetary terms. This usually involves
                  placing a monetary value on health benefits<sup>[2]</sup>.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">As all effects are converted to monetary values, CBA can consider 
                  non-health benefits together with health effects of the digital product. CBA studies often consider non-health benefits such as:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>cost savings (financial benefits)</li>
                  
                  <li>productivity gains (indirect benefits)</li>
                  
                  <li>wellbeing and convenience (intangible benefits)</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What inputs are included? </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>Costs including those of implementing an intervention.</li>
                  
                  <li>Benefits including those resulting from an intervention, such as medical costs averted, productivity gains, and the monetized value of health improvements.</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What output does a cost-benefit analysis provide? </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>CBA provides the net benefits (benefits minus costs) of an intervention.</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> How can decision makers use this information? </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">CBA’s estimated net benefit offers a sense of the economic value provided to society by an intervention.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Decision makers can also use CBA to compare health and non-health interventions because 
                  both costs and benefits are expressed in monetary units. For example, CBA could be used to compare health and environmental interventions.</p><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\">What to use it for </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Use a cost benefit analysis when:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>you want to evaluate whether your digital product is worth the investment compared with different products</li>
                  
                  <li>non-health benefits are an important component of the total effects of using your digital product</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\">Pros</p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Advantages include:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>similar to cost consequence analysis, CBA can include non-health benefits</li>
                  
                  <li>decisions are explicit and transparent because costs and effects are measured in the same units</li>
                  
                  <li>CBA can inform resource allocation decisions across different healthcare settings</li></ul><br>
                  
                  
                  <br><br>
                  
                  <h4><b><p style=\"font-family: 'Times New Roman', Times, serif;\">References</p></b></h4>
                  
                  <ol style=\"font-family: 'Times New Roman', Times, serif;\"><li> <p><a href='https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html'>
                 CDC. Cost-Effectiveness Analysis | POLARIS | ADP-Policy | CDC [Internet]. www.cdc.gov. 2021. Available from: https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html</a></p> </li>
                 
                 <li> <p><a href='https://www.gov.uk/guidance/economic-evaluation-health-economic-studies'>
                 Office for Health Improvement and Disparities. Economic evaluation: health economic studies [Internet]. GOV.UK. 2020. Available from: https://www.gov.uk/guidance/economic-evaluation-health-economic-studies</a>
                 </p> </li></ol>")
            
            
    ),
    #_______________________________________________________________________________________________________________________
    
    tabItem(tabName = "cost_of_illness",
            HTML(paste0("<h1><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Welcome & Overview</p></b></h1>")),
            HTML("<h3><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cost of Illness Analysis </p></b></h3>
            
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost of illness analysis is a way of measuring medical and other
                  costs resulting from a speciﬁc disease or condition.<sup>[1]</sup>.</p>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost-of-illness (COI) was the first economic evaluation
                  technique used in the health field. The principal aim was to measure the economic burden of illness to society<sup>[2]</sup>.</p><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What inputs are included? </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Cost of illness analysis may include direct costs, productivity losses,
                  and intangible costs of a disease or injury. Direct costs from a disease or condition may include:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>Medical costs, such as the cost of diagnostic tests, physician ofﬁce visits,
                  and drugs and medical supplies</li>
                  
                  <li>Non-medical costs, such as travel costs for obtaining care and related childcare costs.</li>
                  
                  <li>Productivity losses include impacts of patient and caregiver participation in an intervention, such as work or leisure time 
                  lost due to participation in the intervention. These costs are generally more complicated to measure than direct costs.</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What output does a cost of illness analysis provide? </p></b></h4>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>Cost of illness analysis provides the economic costs of an illness, injury, or risk factor.</li></ul><br>
                  
                  <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Tyoes of costs </p></b></h4>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">The COI studies traditionally stratify costs into three categories-direct, indirect, and intangible costs.
                  Since the intangible costs have seldom been quantified in COI studies due to the measurement difficulties and related controversies, here we mainly focus
                  on the first two cost categories. The examples of direct and indirect costs associated with health outcomes are presented in Table 1.</p><br>
                  
                  <p style=\"padding: 4px; border: 2px solid black;display: inline-block; width:610px\"><img src=\"coi_cost.png\" width=\"600\" height=\"350\"><br><a href='https://www.rama.mahidol.ac.th/ceb/sites/default/files/public/pdf/course/2014/607/CoI.pdf'> Table 1 :Types of costs</a></p><br>
                  
                  <h5><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Direct costs</p></b></h5>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Being incurred by the health system, society, family and individual patient, 
                  the direct costs consist of healthcare costs and non-healthcare costs. The former is defined as the medical care expenditures for diagnosis,
                  treatment, and rehabilitation, etc., while the latter is related to the consumption of non-healthcare resources like transportation, household
                  expenditures, relocating, property losses, and informal cares of any kinds. The direct cost estimates associated with chronic diseases are higher
                  than those of acute diseases or communicable diseases on condition that the effective and efficacious treatments and prevention methods are adopted<sup>[3]</sup>.</p><br>
                  
                  <h5><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Indirect costs</p></b></h5>
                  
                  <p style=\"font-family: 'Times New Roman', Times, serif;\">Indirect costs in COI studies refer to productivity losses due to morbidity and mortality, 
                  representing the social welfare impact of diseases. These costs are measured through three methods:</p>
                  
                  <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>Human Capital Method (HCM): Estimates the value of an individual's future contribution
                  to society by calculating the present value of their potential earnings, assuming future earnings represent productivity. However, criticized for
                  assuming irreplaceability.</li>
                  
                  <li>Friction Cost Method (FCM): Calculates the value of human capital by considering the costs incurred during the short-term 'friction period'
                  when a sick worker is temporarily replaced from the unemployment pool. Controversial, as it assumes no long-term impact on total productivity.</li>
                  
                  <li>Willingness to Pay Method (WTP): Measures the amount an individual is willing to pay to reduce the risk of illness or mortality, 
                  often determined through surveys or examining preferences in product demand. Utilizes methods like contingent valuation and discrete choice experiments.</li></ul><br>
                  
                  
                  
                  
                  
                  <br><br>
                  
                  <h4><b><p style=\"font-family: 'Times New Roman', Times, serif;\">References</p></b></h4>
                  
                  <ol style=\"font-family: 'Times New Roman', Times, serif;\"><li> <p><a href='https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html'>
                  CDC. Cost-Effectiveness Analysis | POLARIS | ADP-Policy | CDC [Internet]. www.cdc.gov. 2021. Available from: https://www.cdc.gov/policy/polaris/economics/cost-effectiveness/index.html</a></p> </li>
                  
                  <li> <p><a href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4278062/'>
                  1.Jo C. Cost-of-illness studies: concepts, scopes, and methods. Clinical and Molecular Hepatology [Internet]. 2014;20(4):327. Available from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4278062/</a></p> </li>
                  
                  <li> <p><a href='https://pubmed.ncbi.nlm.nih.gov/16139925/'>
                 Tarricone R. Cost-of-illness analysis. What room in health economics? Health Policy. 2006 Jun;77(1):51-63. doi: 10.1016/j.healthpol.2005.07.016. Epub 2005 Sep 1. PMID: 16139925.</a></p> </li></ol>")
    ),
    
    
    #_______________________________________________________________________________________________________________________
    
    # tabItem(tabName = "budget_impact",
    #         HTML(paste0("<h1><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Welcome & Overview</p></b></h1>")),
    #         HTML("<h3><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Budget Impact Analysis </p></b></h3>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">Budget impact analysis (BIA) is an analysis tool that can help you assess the expected changes 
    #              in the health expenditure of the budget holder (for example, the healthcare system) as a result of implementing your digital product<sup>[1]</sup>.</p>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">A budget impact analysis is usually performed in addition to a cost-effectiveness analysis. A cost-effectiveness analysis evaluates 
    #              whether an intervention provides value relative to an existing intervention (with value defined as cost relative to health outcome). A budget impact analysis evaluates whether the high-value 
    #              intervention is affordable. For example, a cost-effectiveness analysis may indicate that Drug A is a good value relative to Drug B because it has an incremental cost-effectiveness ratio (ICER) ,
    #              of $40,000 per Quality-Adjusted Life Year. This means that per person, one needs to spent $40,000 additional dollars to provide each patient with Drug A. If there are 50,000 patients within a 
    #              health system that need this drug, the healthcare system will have an additional $2 billion dollars of budget impact to treat these patients, which may not be affordable<sup>[2]</sup>.</p>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">As a budget impact analysis is often used for resource allocation purposes, it takes a payer's perspective, and uses a short-term 
    #              time horizon (often 1 to 5 years). A budget impact analysis does not use discounting. Results should be presented on an annual or quarterly basis, or in whatever increment of time that is 
    #              relevant to the decision maker.</p>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">The focus of a budget impact analysis is the direct costs of specific resources needed to put the intervention into effect, such as 
    #              supplies, equipment, and staff. Because the budget impact analysis uses a short-term time horizon, and overhead costs are fixed in the short term, these overhead costs are ordinarily excluded 
    #              in budget impact analyses.This distinguishes budget impact analysis from cost-effectiveness studies, which include overhead costs. This difference can be important, as overhead can account for 
    #              a substantial part of the cost of operating a hospital or health care system.</p>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">A budget impact analysis (BIA) estimates financial consequences of adopting a new health technology or intervention 
    #              within a specific health context<sup>[3]</sup>.</p><br>
    #              
    #              <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> What to use it for </p></b></h4>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">Use a BIA when:</p>
    #              
    #              <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>you want to assess the likely financial impact of your product before you implement it</li>
    #              
    #              <li>you need to work out whether your product will be affordable within the decision maker’s budget constraints if it is recommended for use</li></ul><br>
    #              
    #              <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Pros </p></b></h4>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">Advantages of BIA include:</p>
    #              
    #              <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>it helps you to understand costs both incurred and saved by implementing your product</li>
    #              
    #              <li>it gives an estimate of the impact of your product on the decision maker’s budget</li></ul><br>
    #              
    #              <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Cons </p></b></h4>
    #              
    #              <p style=\"font-family: 'Times New Roman', Times, serif;\">Drawbacks of BIA include:</p>
    #              
    #              <ul style=\"font-family: 'Times New Roman', Times, serif;\"><li>it cannot tell you whether your product is good value for money or not</li>
    #              
    #              <li>it usually excludes costs from changes in effects that cannot be monetised, such as benefits captured by clinical measures</li></ul><br>
    #              
    #              <h4><b ><p style=\"font-family: 'Times New Roman', Times, serif;\"> Difference between BIA and CEA </p></b></h4>
    #              
    #              <div class='row'>
    #              <div class='col-sm-6'>
    #                     <h5><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Budget Impact Analysis (BIA)</p></b></h5>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">BIA assesses the financial consequences of a new intervention given the available
    #                     resource and budget</p>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">The time horizon is usually short (1 to 5 years).</p>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">BIA estimates costs and changes in costs.</p>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">The results are reported in cost per member per month (PMPM).</p>
    #              </div><vr>
    #              <div class='col-sm-6'>
    #                     <h5><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Cost-Effectiveness Analysis (CEA)</p></b></h5>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">CEA evaluates the value of a new intervention relative to current ones.</p>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">The time horizon is long (can be a life-time horizon).</p>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">CEA estimates the cost per clinical outcome, such as life year (LY) and quality-adjusted life years (QALY) gained.</p>
    #                     <p style=\"font-family: 'Times New Roman', Times, serif;\">The results are reported in incremental cost-effectiveness ratio (ICER).</p>
    #              </div>
    #              </div><br>
    #              
    #              
    #              
    #              
    #              
    #              
    #              
    #              <br><br>
    #              
    #              <h4><b><p style=\"font-family: 'Times New Roman', Times, serif;\">References</p></b></h4>
    #              
    #              <ol style=\"font-family: 'Times New Roman', Times, serif;\"><li> <p><a href='https://www.gov.uk/guidance/budget-impact-analysis-health-economic-studies'>
    #              Budget impact analysis: health economic studies [Internet]. GOV.UK. Available from: https://www.gov.uk/guidance/budget-impact-analysis-health-economic-studies</a></p> </li>
    #              
    #              <li> <p><a href='https://www.herc.research.va.gov/include/page.asp?id=budget-impact-analysis#:~:text=A%20budget%20impact%20analysis%20takes,the%20population%20is%20explicitly%20considered.'>
    #              Clara DG. HERC: Budget Impact Analysis [Internet]. www.herc.research.va.gov. Available from: https://www.herc.research.va.gov/include/page.asp?id=budget-impact-analysis#:~:text=A%20budget%20impact%20analysis%20takes</a></p> </li>
    #              
    #              <li> <p><a href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4177634/'>
    #              1.Jamshidi HR, Foroutan N, Salamzadeh J. “Budget Impact Analyses”: A Practical Policy Making Tool for Drug Reimbursement Decisions. Iranian Journal of Pharmaceutical Research : IJPR [Internet]. 2014;13(3):1105–9. Available from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4177634/</a></p> </li></ol>")
    #         
    #         
    #         ),
    #_______________________________________________________________________________________________________________________
    
    tabItem(tabName = "cost_effectiveness_tab",
            
            
            HTML(paste0("<h2><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Cost-Effectiveness Analysis</p></b></h2>")),
            uiOutput("checkboxes_ui1"),
            uiOutput("checkboxes_output1"),
            
            uiOutput("checkboxes_ui2"),
            uiOutput("checkboxes_output2"),
            uiOutput("checkboxes_ui3"),
            uiOutput("checkboxes_output3"),
            uiOutput("checkboxes_ui4"),
            uiOutput("checkboxes_output4"),
            uiOutput("checkboxes_ui5"),
            uiOutput("checkboxes_output5"),
            uiOutput("checkboxes_ui6"),
            uiOutput("checkboxes_output6"),
            uiOutput("checkboxes_ui7"),
            uiOutput("checkboxes_output7")),
    
    
    
    
    #uiOutput("bcea_smoke_o")),
    #_______________________________________________________________________________________________________________________
    
    tabItem(tabName = "cost_benefit_tab",
            HTML(paste0("<h2><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Cost-Benefit Analysis</p></b></h2>")),
            
            uiOutput("checkboxes_ui1a"),
            uiOutput("checkboxes_output1a"),
            uiOutput("checkboxes_ui2a"),
            uiOutput("checkboxes_output2a"),
            uiOutput("checkboxes_ui3a"),
            uiOutput("checkboxes_output3a"),
            uiOutput("checkboxes_ui4a"),
            uiOutput("checkboxes_output4a"),
            uiOutput("checkboxes_ui5a"),
            uiOutput("checkboxes_output5a"),
            uiOutput("checkboxes_ui6a"),
            uiOutput("checkboxes_output6a"),
            uiOutput("checkboxes_ui7a"),
            uiOutput("checkboxes_output7a")
            
    ),
    #_______________________________________________________________________________________________________________________
    
    tabItem(tabName = "cost_of_illness_tab",
            HTML(paste0("<h2><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Cost of Illness Analysis</p></b></h2>")),
            
            uiOutput("checkboxes_ui1b"),
            uiOutput("checkboxes_output1b"),
            uiOutput("checkboxes_ui2b"),
            uiOutput("checkboxes_output2b"),
            uiOutput("checkboxes_ui3b"),
            uiOutput("checkboxes_output3b"),
            uiOutput("checkboxes_ui4b"),
            uiOutput("checkboxes_output4b"),
            uiOutput("checkboxes_ui5b"),
            uiOutput("checkboxes_output5b"),
            uiOutput("checkboxes_ui6b"),
            uiOutput("checkboxes_output6b"),
            uiOutput("checkboxes_ui7b"),
            uiOutput("checkboxes_output7b")
            
    ),
    #_______________________________________________________________________________________________________________________
    
    
    
   #_______________________________________________________________________________________________________________________
    
    tabItem(tabName = "budget_impact_tab",
            HTML(paste0("<h2><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Budget Impact Analysis</p></b></h2>"))),
    #_______________________________________________________________________________________________________________________
    
    tabItem(tabName = "video_tab",
            HTML(paste0("<h2><b><p style=\"font-family: 'Times New Roman', Times, serif;\">Video Tutorial</p></b></h2>")))
  )
)

c


#_______________________________________________________________________________________________________________________


ui<-dashboardPage(
  skin="blue",
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
  header=header,
  sidebar=sidebar,
  body=body
)


#_______________________________________________________________________________________________________________________

server <- function(input, output){
  
  output$checkboxes_ui1 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        
        #checkboxInput(inputId = "abt_dataset", label = HTML("<b>About the dataset</b>"), value = TRUE)
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "view_dataset", label = HTML("<b>View dataset</b>"), value = TRUE)
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      #checkboxInput(inputId = "viewing_dataset", label = HTML("<b>View dataset</b>"), value = TRUE)
    }
    else if (input$data_filter1 == "Patient_treatment_data") {
      #checkboxInput(inputId = "viewing_dataset", label = HTML("<b>View dataset</b>"), value = TRUE)
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  
  output$checkboxes_ui2 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        
        #checkboxInput(inputId = "cost_eff_plane",label = HTML("<b>Cost-Effectiveness Plane</b>"), value = TRUE)
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "summary_dataset", label = HTML("<b>Summary of the dataset</b>"), value = TRUE)
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      #checkboxInput(inputId = "decision_analysis1", label = HTML("<b>Decision Analysis</b>"), value = TRUE)
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  output$checkboxes_ui3 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        
        #checkboxInput(inputId = "cost_in_benefit",label = HTML("<b>Cost-Incremental Benefit</b>"), value = TRUE)
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "decision_analysis", label = HTML("<b>Decision Analysis</b>"), value = TRUE)
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      #checkboxInput(inputId = "icera1", label = HTML("<b>Incremental cost-effectiveness ratio (ICER)</b>"), value = TRUE)
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  output$checkboxes_ui4 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        
        #checkboxInput(inputId = "cost_acc_curve",label = HTML("<b>Cost Effectiveness Acceptability Curve</b>"), value = TRUE)
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "icer", label = HTML("<b>Incremental cost-effectiveness ratio (ICER)</b>"), value = TRUE)
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      #checkboxInput(inputId = "cepa1", label = HTML("<b>Cost-effectiveness plane</b>"), value = TRUE)
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  output$checkboxes_ui5 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        
        #checkboxInput(inputId = "inc_ben_dist",label = HTML("<b>Incremental Benefit Distribution</b>"), value = TRUE)
      )
    } else if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "cep", label = HTML("<b>Cost-effectiveness plane</b>"), value = TRUE)
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      #checkboxInput(inputId = "ceaca11", label = HTML("<b>Cost-effectiveness acceptability curves (CEAC)</b>"), value = TRUE)
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  output$checkboxes_ui6 <- renderUI({
    if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "ceac", label = HTML("<b>Cost-effectiveness acceptability curves (CEAC)</b>"), value = TRUE)
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      #checkboxInput(inputId = "ceafa11", label = HTML("<b>Cost-effectiveness acceptability frontier (CEAF)</b>"), value = TRUE)
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  output$checkboxes_ui7 <- renderUI({
    if (input$data_filter == "Demo_dataset") {
      #checkboxInput(inputId = "ceaf", label = HTML("<b>Cost-effectiveness acceptability frontier (CEAF)</b>"), value = TRUE)
    } else {
      NULL
    }
  })
  #_______________________________________________________________________________________________________________________
  #_______________________________________________________________________________________________________________________
  
  
  
  output$checkboxes_output1 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        column(width=12,align="center",  
               box(title=HTML("About Dataset"),
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   collapsed = TRUE,
                   status = "primary",
                   column(width=12,align="left",
                          withSpinner(uiOutput("about_dataset"),type=1)),
                   
                   
               )),
        br()
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      tagList(
        column(width=12,align="center",
               box(title="About Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsibleIcon = "+",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("vw_dataset1"),type=1),
                          withSpinner(uiOutput("vw_dataset2"),type=1),
                          withSpinner(uiOutput("vw_dataset3"),type=1),
                          withSpinner(uiOutput("vw_dataset4"),type=1),
                          withSpinner(uiOutput("vw_dataset5"),type=1))
                   
               )),
        br(),
        column(width=12,align="center",  
               box(title="View Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("vw_dataset6"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadTable1", HTML("<small>Download Data</small>")))
                   )
                   
               ))
        
        
      )
    } else if (input$data_filter == "Upload_dataset" & is.null(input$file1)) {
      tagList(
        column(width=12,align="center",
               box(title="Essebtial Criteria for CEA Dataset",
                   width=12,
                   #collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   #collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("text_condition"),type=1))
                   
               )))
      
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      tagList(
        column(width=12,align="center",
               box(title="View Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("vw_dtset"),type=1))
                   
               )),
        column(width=12,align="center",  
               box(title="Summary of the Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          withSpinner(verbatimTextOutput("vw_dtset1"),type=1))
                   
               )),
        column(width=12,align="center",  
               box(title="Select the important variables",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          #withSpinner(uiOutput("var_dropdown"),type=1),
                          withSpinner(uiOutput("var_dropdown1"),type=1),
                          withSpinner(uiOutput("var_dropdown2"),type=1),
                          withSpinner(uiOutput("var_dropdown3"),type=1),
                          withSpinner(uiOutput("var_dropdown4"),type=1),
                          withSpinner(uiOutput("var_dropdown5"),type=1),
                          withSpinner(uiOutput("text1"),type=1),
                          withSpinner(uiOutput("text2"),type=1),
                          withSpinner(verbatimTextOutput("selected_var_dropdown2"), type = 1),
                          withSpinner(uiOutput("text3"),type=1),
                          withSpinner(verbatimTextOutput("selected_var_dropdown3"), type = 1),
                          withSpinner(uiOutput("text4"),type=1),
                          withSpinner(verbatimTextOutput("selected_var_dropdown4"), type = 1),
                          withSpinner(uiOutput("text5"),type=1),
                          withSpinner(verbatimTextOutput("selected_var_dropdown5"), type = 1),
                          withSpinner(uiOutput("text6"),type=1),
                          withSpinner(verbatimTextOutput("selected_var_dropdown6"), type = 1),)
                   
               )),
        column(width=12,align="center",  
               box(title="View Dataset with specified variables",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          withSpinner(uiOutput("vw_dtseta"),type=1))
                   
               )))
    } 
  })
  #_____________________________________________________________________________
  output$checkboxes_output1a <- renderUI({
    if (input$data_filter1 == "Patient_treatment_data") {
      tagList(
        column(width=12,align="center",  
               box(title=HTML("About Dataset"),
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   collapsed = TRUE,
                   status = "primary",
                   column(width=12,align="left",
                          withSpinner(uiOutput("about_dataset_a"),type=1)),
                   
                   
               )),
        br(),
        column(width=12,align="center",  
               box(title="View Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("vw_dataset6a"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadTable1", HTML("<small>Download Data</small>")))
                   )
                   
               )),
        br(),
        column(width=12,align="center",  
               box(title="Summary of the Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          withSpinner(verbatimTextOutput("sum_dataseta"),type=1))
                   
               )),
        br(),
        column(width=12,align="center",  
               box(title="Net Present Value",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   fluidPage(
                   column(width=12,align="left", 
                          withSpinner(plotOutput("cep3a"),type=1))),
                   #fluidRow(
                    # column(width = 12, align = "right",
                     #       downloadButton("downloadPlot4", HTML("<small>Download Plot</small>")))
                   #),
                   #column(width = 12,align = "left",
                    #      withSpinner(uiOutput("cep4"), type = 1))
                   
                   
               )),
        br(),
        # column(width=12,align="center",  
        #        box(title="Benefit-Cost Ratio (BCR)",
        #            width=12,
        #            collapsible = T,
        #            solidHeader = T,
        #            status = "primary",
        #            collapsed = TRUE,
        #            fluidPage(
        #              column(width=12,align="left", 
        #                     withSpinner(plotOutput("cep3b"),type=1))),
        #            
        #            
        #            
        #        ))
        
      )
    }
  })
  #_______________________________________________________________________________________________________________________
  
  output$checkboxes_output1b <- renderUI({
    if (input$data_filter2 == "Insurance_data") {
      tagList(
        column(width=12,align="center",  
               box(title=HTML("About Dataset"),
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   collapsed = TRUE,
                   status = "primary",
                   column(width=12,align="left",
                          withSpinner(uiOutput("about_dataset_a1"),type=1)),
                   
                   
               )),
        br(),
        column(width=12,align="center",  
               box(title="View Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("vw_dataset6a1"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadTable1", HTML("<small>Download Data</small>")))
                   )
                   
               )),
        br(),
        column(width=12,align="center",
               box(title="Summary of the Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(verbatimTextOutput("sum_dataseta1"),type=1))

               )),
        br(),
        column(width=12,align="center",
               box(title="Box plot of indirect costs by smoking status",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   fluidPage(
                     column(width=12,align="left",
                            withSpinner(plotOutput("cep3b1"),type=1))),


               )),
        br(),
        column(width=12,align="center",  
               box(title="Calculate total indirect costs (productivity loss)",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(uiOutput("vw_dataset6a11"),type=1)),
                   
                   
               )),
        br(),
        column(width=12,align="center",
               box(title="Box plot of indirect costs by smoking status",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   fluidPage(
                     column(width=12,align="left",
                            withSpinner(plotOutput("cep3b11"),type=1))),



               ))
        
      )
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  output$checkboxes_output2 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        column(width=12,align="center", 
               box(title="Cost-Effectiveness Plane",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(plotOutput("bcea_smoke_o"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadPlot0", HTML("<small>Download Plot</small>")))
                   )
                   
               )),
        br()
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      tagList(
        column(width=12,align="center",  
               box(title="Summary of the Dataset",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          withSpinner(verbatimTextOutput("sum_dataset"),type=1))
                   
               ))
        
      )
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      tagList(
        column(width=12,align="center",
               box(title="Summary of the decision analysis performed within a cost-effectiveness analysis (CEA) framework.",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left",
                          withSpinner(verbatimTextOutput("dec_analysisa1"),type=1)),
                   column(width = 12,align = "left",
                          withSpinner(uiOutput("dec_analysisaa2"), type = 1))
                   
               )),
        br(),
        column(
          width = 12,align = "center",
          box(title = "Summary of the pairwise analysis comparing two treatment strategies (Strategy 2 and Strategy 3) to a comparator (Strategy 1).",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              status = "primary",
              collapsed = TRUE,
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("dec_analysisa2"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("dec_analysisaa4"), type = 1))
          )))
    }
  })
  
  #_______________________________________________________________________________________________________________________
  
  
  
  output$checkboxes_output3 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        column(width=12,align="center",  
               div(id = "bcea_smoke_o1_container", style = "background-color: white;"),
               box(title="Expected Incremental Benefit",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          withSpinner(plotOutput("bcea_smoke_o1"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadPlot1", HTML("<small>Download Plot</small>")))
                   )
                   
                   
               )),
        
        br()
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      
      tagList(
        column(width = 12,align = "center",
               box(title = "Description",
                   width = 12,
                   collapsible = TRUE,
                   solidHeader = TRUE,
                   status = "primary",
                   collapsed = TRUE,
                   column(width = 12,align = "left",
                          withSpinner(uiOutput("dec_analysis"), type = 1)
                   )
               )
        ),
        br(),
        column(
          width = 12,align = "center",
          box(title = "Summary of the decision analysis performed within a cost-effectiveness analysis (CEA) framework.",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              status = "primary",
              collapsed = TRUE,
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("dec_analysis1"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("dec_analysis2"), type = 1))
          )),
        br(),
        column(
          width = 12,align = "center",
          box(title = "Summary of the pairwise analysis comparing two treatment strategies (Strategy 2 and Strategy 3) to a comparator (Strategy 1).",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              collapsed = TRUE,
              status = "primary",
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("dec_analysis3"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("dec_analysis4"), type = 1))
          ))
      )
      
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Incremental cost-effectiveness ratio (ICER)",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              collapsed = TRUE,
              status = "primary",
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("icera2"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("icera3"), type = 1))
          ))
      )
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  
  output$checkboxes_output4 <- renderUI({
    if (input$data_filter == "Smoking") {
      tagList(
        column(width=12,align="center",  
               box(title="Cost Effectiveness Acceptibility Curve",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   collapsed = TRUE,
                   status = "primary",
                   column(width=12,align="left", 
                          withSpinner(plotOutput("bcea_smoke_o2"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadPlot2", HTML("<small>Download Plot</small>")))
                   )
                   
               )),
        
        br()
        
      )
    } else if (input$data_filter == "Demo_dataset") {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Incremental cost-effectiveness ratio (ICER)",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              collapsed = TRUE,
              status = "primary",
              column(width = 12,align = "left",
                     withSpinner(uiOutput("icer1"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("icer2"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("icer3"), type = 1))
          ))
      )
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      tagList(
        column(width=12,align="center",  
               
               box(title="Cost-effectiveness plane",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   collapsed = TRUE,
                   status = "primary",
                   column(width=12,align="left", 
                          withSpinner(plotOutput("cepa3"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadPlot7", HTML("<small>Download Plot</small>")))
                   ),
                   column(width = 12,align = "left",
                          withSpinner(uiOutput("cepaa4"), type = 1))
                   
                   
               ))
      )
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  
  output$checkboxes_output5 <- renderUI({
    # if (input$data_filter == "Smoking") {
    #   tagList(
    #     column(width=12,align="center",  
    #            box(title="Incremental Benefit Distribution",
    #                width=12,
    #                collapsible = T,
    #                solidHeader = T,
    #                status = "primary",
    #                collapsed = TRUE,
    #                column(width=12,align="left", 
    #                       withSpinner(plotOutput("bcea_smoke_o3"),type=1)),
    #                fluidRow(
    #                  column(width = 12, align = "right",
    #                         downloadButton("downloadPlot3", HTML("<small>Download Plot</small>")))
    #                )
    #                
    #            ))
    #     
    #   )
    # } else 
    if (input$data_filter == "Demo_dataset") {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Data for plotting a cost-effectiveness plane",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              status = "primary",
              collapsed = TRUE,
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("cep1"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("cep2"), type = 1))
          )),
        column(width=12,align="center",  
               div(id = "bcea_smoke_o1_container", style = "background-color: white;"),
               box(title="Cost-effectiveness plane",
                   width=12,
                   collapsible = T,
                   solidHeader = T,
                   status = "primary",
                   collapsed = TRUE,
                   column(width=12,align="left", 
                          withSpinner(plotOutput("cep3"),type=1)),
                   fluidRow(
                     column(width = 12, align = "right",
                            downloadButton("downloadPlot4", HTML("<small>Download Plot</small>")))
                   ),
                   column(width = 12,align = "left",
                          withSpinner(uiOutput("cep4"), type = 1))
                   
                   
               )),
        
        br()
        
      )
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Cost-effectiveness acceptability curves (CEAC)",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              status = "primary",
              collapsed = TRUE,
              # column(width = 12,align = "left",
              #        withSpinner(verbatimTextOutput("ceaca1"), type = 1)),
              # column(width = 12,align = "left",
              #        withSpinner(uiOutput("ceaca2"), type = 1)),
              # column(width = 12,align = "left",
              #        withSpinner(verbatimTextOutput("ceaca3"), type = 1)),
              # column(width = 12,align = "left",
              #        withSpinner(uiOutput("ceaca4"), type = 1)),
              column(width=12,align="left", 
                     withSpinner(plotOutput("ceaca5"),type=1)),
              fluidRow(
                column(width = 12, align = "right",
                       downloadButton("downloadPlot8", HTML("<small>Download Plot</small>")))
              ),
          ))
      )
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  
  
  output$checkboxes_output6 <- renderUI({
    if (input$data_filter == "Demo_dataset") {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Cost-effectiveness acceptability curves (CEAC)",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              status = "primary",
              collapsed = TRUE,
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("ceac1"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("ceac2"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(verbatimTextOutput("ceac3"), type = 1)),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("ceac4"), type = 1)),
              column(width=12,align="left", 
                     withSpinner(plotOutput("ceac5"),type=1)),
              fluidRow(
                column(width = 12, align = "right",
                       downloadButton("downloadPlot5", HTML("<small>Download Plot</small>")))
              ),
              column(width = 12,align = "left",
                     withSpinner(uiOutput("ceac6"), type = 1))
          )))
    } else if (input$data_filter == "Upload_dataset" & !is.null(input$file1)) {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Cost-effectiveness acceptability frontier (CEAF)",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              collapsed = TRUE,
              status = "primary",
              
              column(width=12,align="left", 
                     withSpinner(plotOutput("ceafa2"),type=1)),
              fluidRow(
                column(width = 12, align = "right",
                       downloadButton("downloadPlot9", HTML("<small>Download Plot</small>")))
              )
              
          ))
        
      )
    }
  })
  #_______________________________________________________________________________________________________________________
  
  
  
  output$checkboxes_output7 <- renderUI({
    if (input$data_filter == "Demo_dataset") {
      tagList(
        column(
          width = 12,align = "center",
          box(title = "Cost-effectiveness acceptability frontier (CEAF)",
              width = 12,
              collapsible = TRUE,
              solidHeader = TRUE,
              collapsed = TRUE,
              status = "primary",
              column(width = 12,align = "left",
                     withSpinner(uiOutput("ceaf1"), type = 1)),
              column(width=12,align="left", 
                     withSpinner(plotOutput("ceaf2"),type=1)),
              fluidRow(
                column(width = 12, align = "right",
                       downloadButton("downloadPlot6", HTML("<small>Download Plot</small>")))
              )
          )))
    } else {
      NULL
    }
  })
  #_______________________________________________________________________________________________________________________
  #_______________________________________________________________________________________________________________________
  
  
  
  
  
  
  output$about_dataset<-renderText({
    if(input$data_filter=='Smoking'){
      #if(input$abt_dataset){
      HTML("
         <p>It is a simple cost-effectiveness analysis using <b>BCEA</b> using the smoking cessation data set contained in the package.
         Data set for the Bayesian model for the cost-effectiveness of smoking cessation interventions</p>
         <b>Description</b><br>
         <p>This data set contains the results of the Bayesian analysis used to model the clinical output and the 
         costs associated with the health economic evaluation of four different smoking cessation interventions.</p>
         <b>Usage</b>
         <p>data(Smoking)</p>
         <b>Format</b>
         <p>A data list including the variables needed for the smoking cessation cost-effectiveness analysis. The variables are as follows:</p>
         <ul><li>c -->    a matrix of 500 simulations from the posterior distribution of the overall costs associated with the four strategies data 
         a dataset containing the characteristics of the smokers in the UK population</li>
         <li>e -->    a matrix of 500 simulations from the posterior distribution of the clinical benefits associated with the four strategies
         life.years -->    a matrix of 500 simulations from the posterior distribution of the life years gained with each strategy</li>
         <li>pi -->   a matrix of 500 simulations from the posterior distribution of the event of smoking cessationwith each strategy</li>
         <li>smoking -->   a data frame containing the inputs needed for the network meta-analysis model. The data.frame object contains:
         nobs: the record ID number, s: the study ID number, i: the intervention ID number, r_i: the number of patients
         who quit smoking, n_i: the total number of patients for the row-specific arm and b_i: the reference intervention for each study</li>
         <li>smoking_output -- > a rjags object obtained by running the network meta-analysis model based on the data contained in the smoking object</li>
         <li>smoking_mat --> a matrix obtained by running the network meta-analysis model based on the data contained in the smoking object</li></ul>
         <p>Treats a vector of labels associated with the four strategies</p>
         ")
      
      #} 
      # else {
      # ""
      # }
    }
  })
  
  #_______________________________________________________________________________________________________________________
  
  
  output$about_dataset_a<-renderText({
    if(input$data_filter1=='Patient_treatment_data'){
      #if(input$abt_dataset){
      HTML("
         <p>It consists of information about 100 patients, with details regarding their treatment group, demographic characteristics, and health economics outcomes.
         Here is a detailed explanation of each variable in the dataset:</p>
         <ul><li>  Patient_ID: Unique identifier for each patient.</li>
         <li>Treatment_Group: Indicates whether the patient received the intervention or was in the control group.</li>
         <li>Age: Age of the patient.</li>
         <li>Gender: Gender of the patient.</li>
         <li>Cost: Cost associated with the intervention (e.g., treatment cost, equipment cost).</li>
         <li>QALYs_Gained: Quality-Adjusted Life Years gained due to the intervention.</li></ul>
         
         ")
      
      #} 
      # else {
      # ""
      # }
    }
  })
  
  output$about_dataset_a1<-renderText({
    if(input$data_filter2=='Insurance_data'){
      #if(input$abt_dataset){
      HTML("
         <p>The dataset is related to health insurance and provides various details about the primary beneficiary. These details include:</p>
         <ul><li> Age: This column provides information about the age of the primary beneficiary.</li>
         <li>Sex: This column indicates the gender of the insurance contractor, which can be either female or male.</li>
         <li>BMI: This column provides the Body Mass Index of the individual. The BMI allows for an understanding of the
         individual's body weight in relation to their height. The ideal BMI is between 18.5 and 24.9.</li>
         <li>Children: This column represents the number of children or dependents that are covered by the individual's health insurance.</li>
         <li>Smoker: This column indicates whether the primary beneficiary is a smoker.</li>
         <li>Region: This column specifies the residential area of the beneficiary in the United States,
         which can be the northeast, southeast, southwest, or northwest regions.</li>
         <li>Charges: This column represents the costs of individual medical expenses that are billed by the health insurance.</li></ul>
         
         ")
      
      #} 
      # else {
      # ""
      # }
    }
  })
  
  
  
  plot_bcea_smoke_cost_eff<-eventReactive(input$cost_eff_plane,{
    #data(Smoking)
    
    treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
    
    bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
    
    
    fig_bcea_smoke<-ceplane.plot(bcea_smoke,
                                 graph = "ggplot2",
                                 wtp = 250,
                                 line = list(color = "red", size = 1),
                                 point = list(color = c("plum", "tomato", "springgreen"), shape = 3:5, size = 2),
                                 icer = list(color = c("red", "orange", "black"), size = 5))
    return(fig_bcea_smoke)
  })
  
  plot_bcea_smoke_cost_in<-eventReactive(input$cost_in_benefit,{
    
    
    #data(Smoking)
    
    treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
    
    bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
    
    
    fig_bcea_smoke<-eib.plot(bcea_smoke,
                             graph = "ggplot2")
    return(fig_bcea_smoke)
  })
  
  plot_bcea_smoke_cost_acc<-eventReactive(input$cost_acc_curve,{
    
    
    #data(Smoking)
    
    treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
    
    bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
    
    
    fig_bcea_smoke<-ceac.plot(bcea_smoke,
                              graph = "ggplot2")
    return(fig_bcea_smoke)
  })
  
  
  plot_bcea_smoke_cost_inc<-eventReactive(input$inc_ben_dist,{
    
    
    #data(Smoking)
    
    treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
    
    bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
    
    
    fig_bcea_smoke<-ib.plot(bcea_smoke,
                            graph = "ggplot2",
                            wtp = 250,
                            line = list(color = "red", size = 1),
                            point = list(color = c("plum", "tomato", "springgreen"), shape = 3:5, size = 2),
                            icer = list(color = c("red", "orange", "black"), size = 5))
    return(fig_bcea_smoke)
  })
  #_______________________________________________________________________________________________________________________
  #_______________________________________________________________________________________________________________________
  
  
  
  
  # 
  # output$bcea_smoke_o<-renderPlot({
  #   if(input$data_filter=='Smoking'){
  #   #  if(input$cost_eff_plane){
  #     plot_bcea_smoke_cost_eff()
  #    # }
  #   } 
  #   })
  
  
  output$bcea_smoke_o<-renderPlot({
    if(input$data_filter=='Smoking'){
      #  if(input$cost_eff_plane){
      treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
      
      bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
      
      
      ceplane.plot(bcea_smoke,
                   graph = "ggplot2",
                   wtp = 250,
                   line = list(color = "red", size = 1),
                   point = list(color = c("plum", "tomato", "springgreen"), shape = 3:5, size = 2),
                   icer = list(color = c("red", "orange", "black"), size = 5))
      # }
    }
  })
  
  # bcea_smoke_o <- reactive({
  #   if (input$data_filter == 'Smoking') {
  #     treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
  #     bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
  #     ceplane.plot(bcea_smoke,
  #                  graph = "ggplot2",
  #                  wtp = 250,
  #                  line = list(color = "red", size = 1),
  #                  point = list(color = c("plum", "tomato", "springgreen"), shape = 3:5, size = 2),
  #                  icer = list(color = c("red", "orange", "black"), size = 5))
  #   }
  # })
  # 
  # output$bcea_smoke_o <- renderPlot({
  #   bcea_smoke_o()
  # })
  
  # output$bcea_smoke_o1<-renderPlot({
  #   if(input$data_filter=='Smoking'){
  #   #  if(input$cost_in_benefit){
  #     plot_bcea_smoke_cost_in()
  #    # }
  #   } 
  # })
  
  bcea_smoke_o1<-reactive({
    if(input$data_filter=='Smoking'){
      #  if(input$cost_in_benefit){
      treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
      
      bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
      
      
      eib.plot(bcea_smoke,graph = "ggplot2")
      # }
    } 
  })
  
  output$bcea_smoke_o1 <- renderPlot({
    bcea_smoke_o1()
  })
  
  # output$bcea_smoke_o2<-renderPlot({
  #   if(input$data_filter=='Smoking'){
  #    #  if(input$cost_acc_curve){
  #     plot_bcea_smoke_cost_acc()
  #    # }
  #   } else if(input$data_filter=='Vaccine'){
  # 
  #   }
  # })
  
  bcea_smoke_o2<-reactive({
    if(input$data_filter=='Smoking'){
      #  if(input$cost_acc_curve){
      treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
      
      bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
      
      
      ceac.plot(bcea_smoke,
                graph = "ggplot2")
      # }
    } 
  })
  
  output$bcea_smoke_o2 <- renderPlot({
    bcea_smoke_o2()
  })
  
  bcea_smoke_o3<-reactive({
    if(input$data_filter=='Smoking'){
      # if(input$inc_ben_dist){
      treats <- c("No intervention", "Self-help", "Individual counselling", "Group counselling")
      
      bcea_smoke <- bcea(eff, cost, ref = 4, interventions = treats, Kmax = 500)
      
      
      ib.plot(bcea_smoke,graph = "ggplot2",
              wtp = 250,
              line = list(color = "red", size = 1),
              point = list(color = c("plum", "tomato", "springgreen"), shape = 3:5, size = 2),
              icer = list(color = c("red", "orange", "black"), size = 5))
      # }
    } 
  })
  
  output$bcea_smoke_o3 <- renderPlot({
    bcea_smoke_o3()
  })
  #_______________________________________________________________________________________________________________________
  
  
  
  output$vw_dataset1<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      #data.table(head(ce))
      a<-nrow(ce)
      
      paste("Number of rows in the dataset is", a)
      
      #renderPrint(a)
      
      #}
    }
  })
  
  output$vw_dataset2<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      b<-ncol(ce)
      paste("Number of columns in the dataset is", b)
      
      
      #}
    }
  })
  
  output$vw_dataset3<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      c<-colnames(ce)
      paste("Columns in the dataset are", c[1], ",",c[2], ",", c[3], ",", c[4], "and", c[5])
      
      
      #}
    }
  })
  
  output$vw_dataset4<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #  if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      d<-unique(ce$strategy)
      paste("Unique stratergies in the dataset are", d[1],",",d[2], "and", d[3])
      
      # }
    }
  })
  
  output$vw_dataset5<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      e<-unique(ce$grp)
      paste("Unique groups in the dataset are", e[1], "and",e[2])
      
      
      # }
    }
  })
  
  output$vw_dataset6<-renderUI({
    if(input$data_filter=='Demo_dataset'){
      #if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      
      renderTable(head(ce,10))
      #}
    }
  })
  
  output$vw_dataset6a<-renderUI({
    if(input$data_filter1 =='Patient_treatment_data'){
      #if(input$view_dataset){
      cba_data <- data.frame(
        Patient_ID = 1:100,  # Unique patient identifiers
        Treatment_Group = sample(c("Control", "Intervention"), 100, replace = TRUE),
        Age = sample(18:80, 100, replace = TRUE),
        Gender = sample(c("Male", "Female"), 100, replace = TRUE),
        Cost = runif(100, min = 100, max = 1000),  # Example cost data
        QALYs_Gained = runif(100, min = 0.1, max = 0.8)  # Example quality-adjusted life years gained
      )
      
      renderTable(head(cba_data,10))
      #}
    }
  })
  
  output$vw_dataset6a1<-renderUI({
    if(input$data_filter2 =='Insurance_data'){
      #health_insurance = read.csv("C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv")
      set.seed(123)
      
      # Create the dataset
      health_insurance <- tibble(
        age = sample(18:63, 55, replace = TRUE),
        sex = sample(c("male", "female"), 55, replace = TRUE),
        bmi = round(runif(55, 17, 42), 2),
        children = sample(0:5, 55, replace = TRUE),
        smoker = sample(c("yes", "no"), 55, replace = TRUE),
        region = sample(c("southwest", "southeast", "northwest", "northeast"), 55, replace = TRUE),
        charges = round(runif(55, 1000, 50000), 2)
      )
      health_insurance <- health_insurance %>%
        mutate(total_medical_costs = charges)
      # req(input$file1)  # Ensure the file is uploaded
      # health_insurance = read.csv(input$file1$C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv, header = input$header)
      renderTable(head(health_insurance,10))
      #}
    }
  })
  output$vw_dataset6a11<-renderUI({
    if(input$data_filter2 =='Insurance_data'){
      #health_insurance = read.csv("C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv")
      set.seed(123)
      
      # Create the dataset
      health_insurance <- tibble(
        age = sample(18:63, 55, replace = TRUE),
        sex = sample(c("male", "female"), 55, replace = TRUE),
        bmi = round(runif(55, 17, 42), 2),
        children = sample(0:5, 55, replace = TRUE),
        smoker = sample(c("yes", "no"), 55, replace = TRUE),
        region = sample(c("southwest", "southeast", "northwest", "northeast"), 55, replace = TRUE),
        charges = round(runif(55, 1000, 50000), 2)
      )
      health_insurance <- health_insurance %>%
        mutate(total_medical_costs = charges)
      total_costs <- tapply(health_insurance$total_medical_costs, health_insurance$age, sum)
      health_insurance <- health_insurance %>%
        mutate(indirect_costs = children * 1000)  # Assume $1000 per child
      
      # req(input$file1)  # Ensure the file is uploaded
      # health_insurance = read.csv(input$file1$C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv, header = input$header)
      renderTable(head(health_insurance,10))
      #}
    }
  })
  
  output$vw_dataset7<-renderUI({
    if(input$data_filter=='Demo_dataset'){
      #if(input$view_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      
      renderTable(ce)
      #}
    }
  })
  
  
  
  output$sum_dataset<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      # if(input$summary_dataset){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      summary(ce)
      #  a=data.table(summary(ce))
      #  
      # b=a[complete.cases(a)]
      # b=b[,-1]
      # setnames(b, c("Column name", "Summary"))
      # renderTable(b)
      #}
    }
  })
  
  output$sum_dataseta<-renderPrint({
    if(input$data_filter1 =='Patient_treatment_data'){
      # if(input$summary_dataset){
      cba_data <- data.frame(
        Patient_ID = 1:100,  # Unique patient identifiers
        Treatment_Group = sample(c("Control", "Intervention"), 100, replace = TRUE),
        Age = sample(18:80, 100, replace = TRUE),
        Gender = sample(c("Male", "Female"), 100, replace = TRUE),
        Cost = runif(100, min = 100, max = 1000),  # Example cost data
        QALYs_Gained = runif(100, min = 0.1, max = 0.8)  # Example quality-adjusted life years gained
      )
      
      summary(cba_data)
      
    }
  })
  
  output$sum_dataseta1<-renderPrint({
    if(input$data_filter1 =='Patient_treatment_data'){
      # if(input$summary_dataset){
      #health_insurance = read.csv("C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv")
      set.seed(123)
      
      # Create the dataset
      health_insurance <- tibble(
        age = sample(18:63, 55, replace = TRUE),
        sex = sample(c("male", "female"), 55, replace = TRUE),
        bmi = round(runif(55, 17, 42), 2),
        children = sample(0:5, 55, replace = TRUE),
        smoker = sample(c("yes", "no"), 55, replace = TRUE),
        region = sample(c("southwest", "southeast", "northwest", "northeast"), 55, replace = TRUE),
        charges = round(runif(55, 1000, 50000), 2)
      )
      summary(health_insurance)
      
      
      
    }
  })
  
  output$dec_analysis<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #  if(input$decision_analysis){
      HTML("<p>Decision analysis is performed within a CEA framework using the cea() and cea_pw() functions.
             The former summarizes results by simultaneously accounting for each treatment strategy in the analysis, 
             while the latter summarizes “pairwise” results in which each treatment is compared to a comparator.</p>
             <p>Both are generic functions that can be used to summarize results from a data.table containing simulated
             costs and QALYs or from a hesim::ce object produced from the $summarize() method of an economic model.</p>
             <p>The first argument is a data.table that contains columns for the parameter sample (sample), treatment strategy 
             (strategy), subgroup (grp), clinical effectiveness (e), and costs (c). Users specify the names of the relevant 
             columns in their output table as strings. The other relevant parameter is k, which is a range of WTP values to use for estimating NMBs.</p>
             <p>Likewise, we can use cea_pw() to summarize the PSA when directly comparing the two treatment strategies
             (Strategy 2 and Strategy 3) to the comparator (Strategy 1). The same inputs are used as in cea() except users 
             must specify the name of the comparator strategy.</p>")
      
      # }
    }
  })
  
  output$dec_analysis1<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      #if(input$decision_analysis){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_out <-  cea(ce, k = seq(0, ktop, 500), sample = "sample", strategy = "strategy",
                      grp = "grp", e = "qalys", c = "cost")
      cea_out
      #  }
    }})
  
  output$dec_analysis2<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #if(input$decision_analysis){
      HTML("<p>The output provides a summary of the decision analysis performed within a cost-effectiveness analysis (CEA) framework.</p>
        <ul><li>The $summary section provides a summary of the results for each treatment strategy and subgroup. It includes the mean values and lower and upper bounds for clinical effectiveness (e) and costs (c).</li>
        <li>The $mce section provides the most cost-effective strategy (best) for each subgroup at different willingness-to-pay (WTP) values (k). It also includes the probability of each strategy being the most cost-effective (prob).</li>
        <li>The $evpi section provides the expected value of perfect information (EVPI) for each subgroup at different WTP values. EVPI represents the value of eliminating all decision uncertainty and making the perfect decision.</li>
        <li>The $nmb section provides the net monetary benefit (NMB) for each strategy and subgroup at different WTP values. NMB is calculated by subtracting the cost from the product of the clinical effectiveness and the WTP.</li></ul>")
      # }
    }})
  
  output$dec_analysis3<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      #if(input$decision_analysis){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_pw_out <-  cea_pw(ce,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = "sample", strategy = "strategy", grp = "grp",
                            e = "qalys", c = "cost")
      cea_pw_out
      #}
    }})
  
  output$dec_analysis4<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$decision_analysis){
      HTML("<p>The output provides a summary of the pairwise analysis comparing two treatment strategies (Strategy 2 and Strategy 3) to a comparator (Strategy 1).</p>
        <ul><li>The $summary section provides the incremental effectiveness (ie) and incremental costs (ic) of the strategies compared to the comparator, as well as the incremental cost-effectiveness ratio (icer).</li>
        <li>The $delta section provides the individual incremental effectiveness and costs for each sample in the analysis.</li>
        <li>The $ceac section provides the cost-effectiveness acceptability curve (CEAC), which shows the probability of each strategy being cost-effective at different WTP values.</li>
        <li>The $inmb section provides the incremental net monetary benefit (INMB) for each strategy and subgroup at different WTP values. INMB is calculated by subtracting the costs of the comparator from the NMB of the strategy being compared.</li></ul>")
      # }
    }})
  
  output$icer1<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$icer){
      HTML("<p>summarizing the results of a cost-effectiveness analysis by calculating and presenting the ICER, incremental QALYs, 
        incremental costs, and incremental NMB for different strategies.</p>
        ")
      # }
    }})
  
  output$icer2<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      # if(input$icer){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_pw_out <-  cea_pw(ce,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = "sample", strategy = "strategy", grp = "grp",
                            e = "qalys", c = "cost")
      icer(cea_pw_out, k = 50000) %>%
        format()
      #  }
    }})
  
  output$icer3<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #if(input$icer){
      HTML("<p>Group 1:</p>
        <ol><li>Incremental QALYs: This represents the average incremental quality-adjusted life years (QALYs) gained by Strategy 2 compared to the baseline. The estimated value is 2.01, with a 95% confidence interval ranging from 0.33 to 3.57.</li>
        <li>Incremental costs: This represents the average incremental costs incurred by Strategy 2 compared to the baseline. The estimated value is 60,892, with a 95% confidence interval ranging from 44,572 to 80,072.</li>
        <li>Incremental NMB: This represents the average incremental net monetary benefit (NMB) gained by Strategy 2 compared to the baseline. The estimated value is 39,818, with a 95% confidence interval ranging from -45,772 to 122,885.</li>
        <li>ICER: This is the Incremental Cost-Effectiveness Ratio, which is calculated by dividing the incremental costs by the incremental QALYs. In this case, the ICER for Group 1 is 30,231, indicating that Strategy 2 costs $30,231 for each additional QALY gained compared to the baseline.</li></ol>
             <br>
             <p>Group 2:</p>
        <ol><li>Incremental QALYs: This represents the average incremental QALYs gained by Strategy 3 compared to the baseline. The estimated value is 2.50, with a 95% confidence interval ranging from 0.90 to 4.12.</li>
        <li>Incremental costs: This represents the average incremental costs incurred by Strategy 3 compared to the baseline. The estimated value is 60,536, with a 95% confidence interval ranging from 45,682 to 80,402.</li>
        <li>Incremental NMB: This represents the average incremental NMB gained by Strategy 3 compared to the baseline. The estimated value is 64,513, with a 95% confidence interval ranging from -21,402 to 144,355.</li>
        <li>ICER: This is the ICER for Group 2, which is calculated by dividing the incremental costs by the incremental QALYs. In this case, the ICER for Group 2 is 24,205.</li></ol>")
      #  }
    }})
  
  output$downloadPlot0 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(bcea_smoke_o())
      dev.off()
    }
  )
  
  
  
  
  output$downloadPlot1 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(bcea_smoke_o1())
      dev.off()
    }
  )
  
  
  
  
  output$downloadPlot2 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(bcea_smoke_o2())
      dev.off()
    }
  )
  
  output$downloadPlot3 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(bcea_smoke_o3())
      dev.off()
    }
  )
  
  output$cep1<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      #if(input$cep){
      set.seed(11)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_pw_out <-  cea_pw(ce,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = "sample", strategy = "strategy", grp = "grp",
                            e = "qalys", c = "cost")
      cea_pw_out$delta
      #  }
    }})
  
  output$cep2<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #  if(input$cep){
      HTML("<p>The \"ie\" column represents the incremental effectiveness, 
        which is the difference in effectiveness (measured in QALYs) between the treatment strategy and the comparator. 
        The \"ic\" column represents the incremental cost, which is the difference in cost between the treatment strategy and the comparator. 
             By plotting these incremental effectiveness and cost values on a cost-effectiveness plane, we can visualize the uncertainty 
             and magnitude of the estimates. Each point on the plot represents a specific random draw from the probabilistic sensitivity analysis (PSA).</p>")
      # }
    }})
  
  
  cep3<-reactive({
    if(input$data_filter=='Demo_dataset'){
      #   if(input$cep){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_pw_out <-  cea_pw(ce,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = "sample", strategy = "strategy", grp = "grp",
                            e = "qalys", c = "cost")
      theme_set(theme_bw())
      plot_ceplane(cea_pw_out, k = 50000)
      #  }
    }})
  output$cep3<-renderPlot({
    cep3()
  })
  
  # cep3a<-reactive({
  #   if(input$data_filter=='Patient_treatment_analysis'){
  #     cba_data <- data.frame(
  #       Patient_ID = 1:100,  # Unique patient identifiers
  #       Treatment_Group = sample(c("Control", "Intervention"), 100, replace = TRUE),
  #       Age = sample(18:80, 100, replace = TRUE),
  #       Gender = sample(c("Male", "Female"), 100, replace = TRUE),
  #       Cost = runif(100, min = 100, max = 1000),  # Example cost data
  #       QALYs_Gained = runif(100, min = 0.1, max = 0.8)  # Example quality-adjusted life years gained
  #     )
  #     discount_rate <- 0.05  # Example discount rate (adjust as needed)
  #     cba_data <- cba_data %>%
  #       mutate(PV_Benefits = QALYs_Gained / (1 + discount_rate)^(Age / 10),
  #              PV_Costs = Cost / (1 + discount_rate)^(Age / 10))
  #     
  #     NPV <- sum(cba_data$PV_Benefits) - sum(cba_data$PV_Costs)
  #     discount_rates <- seq(0.02, 0.1, by = 0.01)
  #     
  #     NPV_values <- sapply(discount_rates, function(rate) {
  #       PV_Benefits <- cba_data$QALYs_Gained / (1 + rate)^(cba_data$Age / 10)
  #       PV_Costs <- cba_data$Cost / (1 + rate)^(cba_data$Age / 10)
  #       sum(PV_Benefits) - sum(PV_Costs)
  #     })
  #     
  #     #list(discount_rates = discount_rates, NPV_values = NPV_values)
  #     plot(discount_rates, NPV_values, type = "l", xlab = "Discount Rate", ylab = "NPV",
  #         main = "Sensitivity Analysis: NPV vs. Discount Rate")
  #     
  #     #abline(h = 0, col = "red", lty = 2)
  #   }})
  # 
  # output$cep3a<-renderPlot({
  #   cep3a()
  #   
  # })
  cep3a <- reactive({
    req(input$data_filter1) # This function will stop your reactive from executing before the input has been selected
    
    if (input$data_filter1 == 'Patient_treatment_data') {
      cba_data <- data.frame(
        Patient_ID = 1:100,  
        Treatment_Group = sample(c("Control", "Intervention"), 100, replace = TRUE),
        Age = sample(18:80, 100, replace = TRUE),
        Gender = sample(c("Male", "Female"), 100, replace = TRUE),
        Cost = runif(100, min = 100, max = 1000),  
        QALYs_Gained = runif(100, min = 0.1, max = 0.8)  
      )
      discount_rate <- 0.05  
      cba_data <- cba_data %>%
        mutate(PV_Benefits = QALYs_Gained / (1 + discount_rate)^(Age / 10),
               PV_Costs = Cost / (1 + discount_rate)^(Age / 10))
      
      NPV <- sum(cba_data$PV_Benefits) - sum(cba_data$PV_Costs)
      discount_rates <- seq(0.02, 0.1, by = 0.01)
      
      NPV_values <- sapply(discount_rates, function(rate) {
        PV_Benefits <- cba_data$QALYs_Gained / (1 + rate)^(cba_data$Age / 10)
        PV_Costs <- cba_data$Cost / (1 + rate)^(cba_data$Age / 10)
        sum(PV_Benefits) - sum(PV_Costs)
      })
      
      # Create the plot and return it
      plot(discount_rates, NPV_values, type = "l", xlab = "Discount Rate", ylab = "NPV",
           main = "Sensitivity Analysis: NPV vs. Discount Rate")
    } else { 
      return(NULL) # You can return NULL or a plot with no data to make sure nothing is shown if the input is not 'Patient_treatment_analysis'
    }
  })
  
  output$cep3a <- renderPlot({
    cep3a()
  })
  
  cep3b <- reactive({
    req(input$data_filter1) # This function will stop your reactive from executing before the input has been selected
    
    if (input$data_filter1 == 'Patient_treatment_data') {
      cba_data <- data.frame(
        Patient_ID = 1:100,  
        Treatment_Group = sample(c("Control", "Intervention"), 100, replace = TRUE),
        Age = sample(18:80, 100, replace = TRUE),
        Gender = sample(c("Male", "Female"), 100, replace = TRUE),
        Cost = runif(100, min = 100, max = 1000),  
        QALYs_Gained = runif(100, min = 0.1, max = 0.8)  
      )
      discount_rate <- 0.05  
      cba_data <- cba_data %>%
        mutate(PV_Benefits = QALYs_Gained / (1 + discount_rate)^(Age / 10),
               PV_Costs = Cost / (1 + discount_rate)^(Age / 10))
      
      BCR <- sum(cba_data$PV_Benefits) / sum(cba_data$PV_Costs)
      discount_rates <- seq(0.02, 0.1, by = 0.01)
      
      NPV_values <- sapply(discount_rates, function(rate) {
        sum(cba_data$PV_Benefits) - sum(cba_data$PV_Costs * (1 + rate)^(cba_data$Age / 10))
      })
      plot(discount_rates, BCR_values, type = "l", xlab = "Discount Rate", ylab = "BCR",
           main = "Sensitivity Analysis: BCR vs. Discount Rate")  # BCR = 1 line
      
      
     
    } else { 
      return(NULL) # You can return NULL or a plot with no data to make sure nothing is shown if the input is not 'Patient_treatment_analysis'
    }
  })
  
  output$cep3b <- renderPlot({
    cep3b()
  })
  # cep3a <- reactive({
  #   if (input$data_filter == 'Patient_treatment_analysis') {
  #     cba_data <- data.frame(
  #       Patient_ID = 1:100,  # Unique patient identifiers
  #       Treatment_Group = sample(c("Control", "Intervention"), 100, replace = TRUE),
  #       Age = sample(18:80, 100, replace = TRUE),
  #       Gender = sample(c("Male", "Female"), 100, replace = TRUE),
  #       Cost = runif(100, min = 100, max = 1000),  # Example cost data
  #       QALYs_Gained = runif(100, min = 0.1, max = 0.8)  # Example quality-adjusted life years gained
  #     )
  #     discount_rate <- 0.05  # Example discount rate (adjust as needed)
  #     cba_data <- cba_data %>%
  #       mutate(PV_Benefits = QALYs_Gained / (1 + discount_rate)^(Age / 10),
  #              PV_Costs = Cost / (1 + discount_rate)^(Age / 10))
  #     
  #     NPV <- sum(cba_data$PV_Benefits) - sum(cba_data$PV_Costs)
  #     discount_rates <- seq(0.02, 0.1, by = 0.01)
  #     
  #     NPV_values <- sapply(discount_rates, function(rate) {
  #       PV_Benefits <- cba_data$QALYs_Gained / (1 + rate)^(cba_data$Age / 10)
  #       PV_Costs <- cba_data$Cost / (1 + rate)^(cba_data$Age / 10)
  #       sum(PV_Benefits) - sum(PV_Costs)
  #     })
  #     
  #     # Create the plot and return it
  #     plot(discount_rates, NPV_values, type = "l", xlab = "Discount Rate", ylab = "NPV",
  #          main = "Sensitivity Analysis: NPV vs. Discount Rate")
  #   }
  # })
  # 
  # output$cep3a <- renderPlot({
  #   cep3a()
  # })
  
  cep3b1 <- reactive({
    req(input$data_filter2) # This function will stop your reactive from executing before the input has been selected
    
    if (input$data_filter2 == 'Insurance_data') {
      #health_insurance = read.csv("C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv")
      set.seed(123)
      
      # Create the dataset
      health_insurance <- tibble(
        age = sample(18:63, 55, replace = TRUE),
        sex = sample(c("male", "female"), 55, replace = TRUE),
        bmi = round(runif(55, 17, 42), 2),
        children = sample(0:5, 55, replace = TRUE),
        smoker = sample(c("yes", "no"), 55, replace = TRUE),
        region = sample(c("southwest", "southeast", "northwest", "northeast"), 55, replace = TRUE),
        charges = round(runif(55, 1000, 50000), 2)
      )
      health_insurance <- health_insurance %>%
        mutate(total_medical_costs = charges)
      total_costs <- tapply(health_insurance$total_medical_costs, health_insurance$age, sum)
      barplot(total_costs, main = "Medical Costs by Age", xlab = "Age", ylab = "Total Medical Costs", col = "skyblue")
      
      
    } else { 
      return(NULL) # You can return NULL or a plot with no data to make sure nothing is shown if the input is not 'Patient_treatment_analysis'
    }
  })
  
  output$cep3b1 <- renderPlot({
    cep3b1()
  })
  
  cep3b11 <- reactive({
    req(input$data_filter2) # This function will stop your reactive from executing before the input has been selected
    
    if (input$data_filter2 == 'Insurance_data') {
      #health_insurance = read.csv("C:/Users/sherith3/OneDrive - Novartis Pharma AG/Files/R/Thesis/main files/HTA_new1/insurance.csv")
      set.seed(123)
      
      # Create the dataset
      health_insurance <- tibble(
        age = sample(18:63, 55, replace = TRUE),
        sex = sample(c("male", "female"), 55, replace = TRUE),
        bmi = round(runif(55, 17, 42), 2),
        children = sample(0:5, 55, replace = TRUE),
        smoker = sample(c("yes", "no"), 55, replace = TRUE),
        region = sample(c("southwest", "southeast", "northwest", "northeast"), 55, replace = TRUE),
        charges = round(runif(55, 1000, 50000), 2)
      )
      health_insurance <- health_insurance %>%
        mutate(total_medical_costs = charges)
      total_costs <- tapply(health_insurance$total_medical_costs, health_insurance$age, sum)
      health_insurance <- health_insurance %>%
        mutate(indirect_costs = children * 1000)  # Assume $1000 per child
      
      boxplot(indirect_costs ~ smoker, data = health_insurance, 
              main = "Indirect Costs by Smoking Status", xlab = "Smoking Status", ylab = "Total Indirect Costs",
              col = "lightgreen")
      
      
      
      
    } else { 
      return(NULL) # You can return NULL or a plot with no data to make sure nothing is shown if the input is not 'Patient_treatment_analysis'
    }
  })
  
  output$cep3b11 <- renderPlot({
    cep3b11()
  })
  
  output$downloadPlot4 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(cep3())
      dev.off()
    }
  )
  
  output$cep4<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$cep){
      HTML("<p> The plot is a cost-effectiveness plane that shows the incremental effectiveness (in terms of QALYs) 
             of a treatment strategy relative to a comparator, plotted against the incremental cost of the treatment strategy. </p>
             <p>The x-axis represents the incremental QALYs, which is the difference in QALYs between the treatment strategy and the comparator. 
             The y-axis represents the incremental costs, which is the difference in costs between the treatment strategy and the comparator.</p>
             <p>The dotted line in the plot is the Willingness-to-Pay (WTP) line, which represents the threshold of cost-effectiveness. The slope of the WTP line is
             equal to the value of \"k\". Points below the WTP line are considered cost-effective, indicating that the treatment strategy provides good value for money. 
             Points above the WTP line are not considered cost-effective.</p>
             <p>the points above the dotted line represent treatment strategies that have higher incremental costs and lower incremental QALYs compared to the comparator. 
             These strategies are generally not considered cost-effective. On the other hand, points below the dotted line represent treatment strategies that 
             have lower incremental costs and higher incremental QALYs compared to the comparator, making them cost-effective.</p>
             <p>Therefore, for Group 1, Stratergy 2 is more cost effective and for Group 2, Stratergy 3 is more cost effective.</p>")
      #}
    }})
  
  output$ceac1<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      #  if(input$ceac){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_pw_out <-  cea_pw(ce,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = "sample", strategy = "strategy", grp = "grp",
                            e = "qalys", c = "cost")
      ce <- ce[, nmb := 50000 * qalys - cost]
      random_rows <- sample(1:n_samples, 10)
      nmb <- dcast(ce[sample %in% random_rows & grp == "Group 2"], 
                   sample ~ strategy, value.var = "nmb")
      setnames(nmb, colnames(nmb), c("sample", "nmb1", "nmb2", "nmb3"))
      nmb <- nmb[, maxj := apply(nmb[, .(nmb1, nmb2, nmb3)], 1, which.max)]
      nmb <- nmb[, maxj := factor(maxj, levels = c(1, 2, 3))]
      nmb
      #  }
    }})
  
  output$ceac2<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #if(input$ceac){
      HTML("<p>The \"nmb1\", \"nmb2\", and \"nmb3\" columns represent the NMB values for strategy 1, strategy 2, and strategy 3, respectively.
             The \"maxj\" column indicates the strategy with the highest NMB for each sample.</p>")
      #  }
    }})
  
  output$ceac3<-renderPrint({
    if(input$data_filter=='Demo_dataset'){
      #if(input$ceac){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_pw_out <-  cea_pw(ce,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = "sample", strategy = "strategy", grp = "grp",
                            e = "qalys", c = "cost")
      ce <- ce[, nmb := 50000 * qalys - cost]
      random_rows <- sample(1:n_samples, 10)
      nmb <- dcast(ce[sample %in% random_rows & grp == "Group 2"], 
                   sample ~ strategy, value.var = "nmb")
      setnames(nmb, colnames(nmb), c("sample", "nmb1", "nmb2", "nmb3"))
      nmb <- nmb[, maxj := apply(nmb[, .(nmb1, nmb2, nmb3)], 1, which.max)]
      nmb <- nmb[, maxj := factor(maxj, levels = c(1, 2, 3))]
      
      mce <- prop.table(table(nmb$maxj))
      mce
      #  }
    }})
  
  output$ceac4<-renderText({
    if(input$data_filter=='Demo_dataset'){
      #if(input$ceac){
      HTML("<p>It calculates the proportion of times that each treatment strategy has the highest Net Monetary Benefit (NMB). 
             Treatment strategy 3 appears to have the highest NMB most frequently, followed by treatment strategy 2.</p>")
      #  }
    }})
  
  ceac5<-reactive({
    if(input$data_filter=='Demo_dataset'){
      # if(input$ceac){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_out <-  cea(ce, k = seq(0, ktop, 500), sample = "sample", strategy = "strategy",
                      grp = "grp", e = "qalys", c = "cost")
      
      plot_ceac(cea_out)
      #  }
    }})
  
  output$ceac5<- renderPlot({
    ceac5()
  })
  
  output$downloadPlot5 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(ceac5())
      dev.off()
    }
  )
  
  output$ceac6<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$ceac){
      HTML("<p>In group 1, Strategy 2 provides the greatest NMBs with high probability for almost all reasonable values of k. 
             In group 2, the results are less certain, although Strategy 3 provides the greatest NMBs with a higher probability 
             than Strategy 2 for most values of k.</p>")
      #  }
    }})
  
  output$ceaf1<-renderText({
    if(input$data_filter=='Demo_dataset'){
      # if(input$ceaf){
      HTML("<p>One drawback of a CEAC is that the probability of being cost-effective cannot be used to determine the optimal treatment option.
        Instead, if a decision-makers objective is to maximize health gain, then decisions should be based on the expected NMB.
        The CEAF, which plots the probability that the optimal treatment strategy (i.e., the strategy with the highest expected NMB)
        is cost-effective, is appropriate in this context.</p>
             <p>A CEAF curve can be created by using the best column to subset to the treatment strategy with the highest expected 
             NMB for each WTP value and group.</p>")
      #  }
    }})
  
  ceaf2<-reactive({
    if(input$data_filter=='Demo_dataset'){
      #  if(input$ceaf){
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      ktop <- 200000
      cea_out <-  cea(ce, k = seq(0, ktop, 500), sample = "sample", strategy = "strategy",
                      grp = "grp", e = "qalys", c = "cost")
      
      plot_ceaf(cea_out)
      #  }
    }})
  
  output$ceaf2 <- renderPlot({
    ceaf2()
  })
  
  output$downloadPlot6 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(ceaf2())
      dev.off()
    }
  )
  
  
  
  output$downloadTable1 <- downloadHandler(
    
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      set.seed(131)
      n_samples <- 1000
      c <- vector(mode = "list", length = 6)
      names(c) <- c("Strategy 1, Grp 1", "Strategy 1, Grp 2", "Strategy 2, Grp 1",
                    "Strategy 2, Grp 2", "Strategy 3, Grp 1", "Strategy 3, Grp 2")
      
      c[[1]] <- rlnorm(n_samples, 2, .1)
      c[[2]] <- rlnorm(n_samples, 2, .1)
      c[[3]] <- rlnorm(n_samples, 11, .15)
      c[[4]] <- rlnorm(n_samples, 11, .15)
      c[[5]] <- rlnorm(n_samples, 11, .15)
      c[[6]] <- rlnorm(n_samples, 11, .15)
      
      e <- c
      e[[1]] <- rnorm(n_samples, 8, .2)
      e[[2]] <- rnorm(n_samples, 8, .2)
      e[[3]] <- rnorm(n_samples, 10, .8)
      e[[4]] <- rnorm(n_samples, 10.5, .8)
      e[[5]] <- rnorm(n_samples, 8.5, .6)
      e[[6]] <- rnorm(n_samples, 11, .6)
      library("data.table")
      ce <- data.table(sample = rep(seq(n_samples), length(e)),
                       strategy = rep(paste0("Strategy ", seq(1, 3)),
                                      each = n_samples * 2),
                       grp = rep(rep(c("Group 1", "Group 2"),
                                     each = n_samples), 3),
                       cost = do.call("c", c), qalys = do.call("c", e))
      write.csv(ce, con)
    }
  )
  
  
  #_______________________________________________________________________________________________________________________
  
  output$text_condition <- renderText({
    data_df <- data()
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      HTML("<b>Ensure your data meets the following criteria before uploading to the dashboard</b>
           <ul><li>Standardized Format: Data must be in a recognized format (CSV, Excel, JSON) with a clear header row.</li>
           <li>When preparing your dataset for upload to the CEA dashboard, please note that the column names and their order can vary.
           However, it is imperative that the dataset includes specific columns for each of the following categories:<br>
           <ul><li>Sample Identifier: A unique identifier for each data entry.</li>
           <li>Strategy: The intervention or strategy being evaluated.</li>
           <li>Group: The subgroup or population segment under analysis.</li>
           <li>Cost: The economic cost associated with the strategy.</li>
           <li>QALYs: The effectiveness measure in quality-adjusted life years.</li></ul></li>
           <li>Structured Data: The dataset should follow a logical structure with the specified order of columns.</li>
           <li>Complete Entries: All dataset entries must be complete, with no missing or null values.</li>
           <li>Uniform Measurement Units: Costs should be in a single currency, and effectiveness measured in QALYs.</li>
           <li>Data Uniformity: Ensure consistent use of scales and labels throughout the dataset.</li>
           <li>Anonymity and Ethics: Data must be anonymized, with all personal identifiers removed.</li>
           <li>Statistical Soundness: The dataset should be large enough for valid statistical analysis and free from outliers that could distort results.</li></ul>")
      
      #  }
    }})
  
  data <- reactive({
    infile <- input$file1
    if (is.null(infile)) {
      return(NULL)
    }
    read.csv(infile$datapath, header = TRUE)
  })
  
  
  
  
  output$vw_dtset<-renderUI({
    data_df<-data()
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      
      renderTable(head(data_df,10))
      
      #  }
    }})
  
  output$vw_dtset1<-renderPrint({
    data_df<-data()
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      
      summary(data_df)
      
      #  }
    }})
  
  output$row_names <- renderPrint({
    data_df <- data()
    if(input$data_filter=='Upload_dataset'){
      # if(input$viewing_dataset){
      colnm<- colnames(data_df)
      colnm
      
      #  }
    }})
  
  output$text1 <- renderText({
    data_df <- data()
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      HTML("<b>Summary of selected variables</b>")
      
      #  }
    }})
  
  # output$var_dropdown <- renderUI({
  #   col_names <- colnames(data())
  #   if(input$data_filter=='Upload_dataset'){
  #     #if(input$viewing_dataset){
  #     selectInput("selectedVariables", "Select important variables:", choices = col_names, multiple = TRUE, selected = input$selectedVariables)
  # 
  #  # }
  # }})
  output$var_dropdown1 <- renderUI({
    col_names <- colnames(data())
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      selectInput("sampleVariable", "Select sample variable:", choices = col_names, selected = NULL)
    }
  })
  
  output$var_dropdown2 <- renderUI({
    col_names <- colnames(data())
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      selectInput("strategyVariable", "Select strategy variable:", choices = col_names, selected = NULL)
      # }
    }
  })
  
  output$var_dropdown3 <- renderUI({
    col_names <- colnames(data())
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      selectInput("groupVariable", "Select group variable:", choices = col_names, selected = NULL)
      # }
    }
  })
  
  output$var_dropdown4 <- renderUI({
    col_names <- colnames(data())
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      selectInput("costVariable", "Select cost variable:", choices = col_names, selected = NULL)
      # }
    }
  })
  output$var_dropdown5 <- renderUI({
    col_names <- colnames(data())
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      selectInput("qalysVariable", "Select qalys variable:", choices = col_names, selected = NULL)
      # }
    }
  })
  
  
  
  
  output$text2 <- renderText({
    data_df <- data()
    # selected_vars <- input$selectedVariables
    # sample <- input$sampleVariable
    # strategy <- input$strategyVariable
    # grp <- input$groupVariable
    # cost <- input$costVariable
    # qalys <- input$qalysVariable
    selected_vars <- input$sampleVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      if (!is.null(selected_vars)) {
        paste("Summary of", selected_vars)
        
        #}
      }}})
  
  output$selected_var_dropdown2 <- renderPrint({
    data_df <- data()
    col_names <- colnames(data())
    selected_vars <- input$sampleVariable
    if (!is.null(selected_vars)) {
      summaries <- lapply(selected_vars, function(var) {
        paste("summary of", var)
        summary(data_df[[var]])
        
      })
      summaries
      
    }
  })
  
  output$text3 <- renderText({
    data_df <- data()
    #selected_vars <- input$selectedVariables
    
    selected_vars <- input$strategyVariable
    
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      if (!is.null(selected_vars)) {
        paste("Summary of", selected_vars)
        
        #}
      }}})
  
  output$selected_var_dropdown3 <- renderPrint({
    data_df <- data()
    selected_vars <- input$strategyVariable
    if (!is.null(selected_vars)) {
      summaries <- lapply(selected_vars, function(var) {
        paste("summary of", var)
        summary(data_df[[var]])
        
      })
      summaries
      
    }
  })
  
  output$text4 <- renderText({
    data_df <- data()
    
    selected_vars <- input$groupVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      if (!is.null(selected_vars)) {
        paste("Summary of", selected_vars)
        
        #}
      }}})
  
  output$selected_var_dropdown4 <- renderPrint({
    data_df <- data()
    selected_vars <- input$groupVariable
    if (!is.null(selected_vars)) {
      summaries <- lapply(selected_vars, function(var) {
        paste("summary of", var)
        summary(data_df[[var]])
        
      })
      summaries
      
    }
  })
  
  output$text5 <- renderText({
    data_df <- data()
    
    selected_vars <- input$costVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      if (!is.null(selected_vars)) {
        paste("Summary of", selected_vars)
        
        #}
      }}})
  
  output$selected_var_dropdown5 <- renderPrint({
    data_df <- data()
    selected_vars <- input$costVariable
    if (!is.null(selected_vars)) {
      summaries <- lapply(selected_vars, function(var) {
        paste("summary of", var)
        summary(data_df[[var]])
        
      })
      summaries
      
    }
  })
  
  output$text6 <- renderText({
    data_df <- data()
    
    selected_vars <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      if (!is.null(selected_vars)) {
        paste("Summary of", selected_vars)
        
        #}
      }}})
  
  output$selected_var_dropdown6 <- renderPrint({
    data_df <- data()
    selected_vars <- input$qalysVariable
    if (!is.null(selected_vars)) {
      summaries <- lapply(selected_vars, function(var) {
        paste("summary of", var)
        summary(data_df[[var]])
        
      })
      summaries
      
    }
  })
  
  
  
  # filtered_data <- reactive({
  #   data_df <- data()
  #   selected_vars <- input$selectedVariables
  #   if (!is.null(selected_vars)) {
  #     filtered_df <- data_df[, selected_vars, drop = FALSE]
  #     return(filtered_df)
  #   }
  #   return(NULL)
  # })
  
  filtered_data <- reactive({
    data_df <- data()
    col_names <- colnames(data_df)
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    
    selected_vars <- c(sample, strategy, grp, cost, qalys)
    missing_vars <- setdiff(selected_vars, col_names)
    
    if (length(missing_vars) > 0) {
      message(paste("Missing columns:", paste(missing_vars, collapse = ", ")))
      return(NULL)
    }
    
    if (!is.null(selected_vars)) {
      filtered_df <- data_df[, selected_vars, drop = FALSE]
      return(filtered_df)
    }
    return(NULL)
  })
  
  output$vw_dtseta <- renderUI({
    filtered_df <- filtered_data()
    if(input$data_filter=='Upload_dataset'){
      #if(input$viewing_dataset){
      if (!is.null(filtered_df)) {
        renderTable(head(filtered_df, 10))
        #}
      }}
  })
  
  
  # output$dec_analysisa1<-renderPrint({
  #   filtered_df <- filtered_data()
  #   if(input$data_filter=='Upload_dataset'){
  #     if(input$decision_analysis1){
  #       if (!is.null(filtered_df)) {
  #       ktop <- 200000
  #       cea_out <-  cea(filtered_df, k = seq(0, ktop, 500), sample = sample, strategy = strategy, grp = grp, e = qalys, c = cost)
  #       cea_out
  #     }}}})
  
  output$dec_analysisa1 <- renderPrint({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if (input$data_filter == 'Upload_dataset' && !is.null(filtered_df)) {
      #&& input$decision_analysis1
      
      ktop <- 200000
      cea_out <- cea(filtered_df, k = seq(0, ktop, 500), sample = sample, strategy = strategy, grp = grp, e = qalys, c = cost)
      cea_out
    }
  })
  
  output$dec_analysisa2<-renderPrint({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      # if(input$decision_analysis1){
      
      ktop <- 200000
      cea_pw_out <-  cea_pw(filtered_df,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = sample, strategy = strategy, grp = grp,
                            e = qalys, c = cost)
      cea_pw_out
      #  }
    }})
  
  
  
  output$icera2<-renderPrint({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$icera1){
      
      ktop <- 200000
      cea_pw_out <-  cea_pw(filtered_df,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = sample, strategy = strategy, grp = grp,
                            e = qalys, c = cost)
      icer(cea_pw_out, k = 50000) %>%
        format()
      #  }
    }})
  
  
  cepa3<-reactive({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      # if(input$cepa1){
      
      ktop <- 200000
      cea_pw_out <-  cea_pw(filtered_df,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = sample, strategy = strategy, grp = grp,
                            e = qalys, c = cost)
      theme_set(theme_bw())
      plot_ceplane(cea_pw_out, k = 50000)
      # }
    }})
  
  output$cepa3 <- renderPlot({
    cepa3()
  })
  output$ceaca1<-renderPrint({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      # if(input$ceaca11){
      filtered_df <- setDT(filtered_df)
      
      ktop <- 200000
      cea_pw_out <-  cea_pw(filtered_df,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = sample, strategy = strategy, grp = grp,
                            e = qalys, c = cost)
      filtered_df <- filtered_df[, nmb := 50000 * qalys - cost]
      random_rows <- sample(1:n_samples, 10)
      nmb <- dcast(filtered_df[sample %in% random_rows & grp == "Group 2"], 
                   sample ~ strategy, value.var = "nmb")
      setnames(nmb, colnames(nmb), c("sample", "nmb1", "nmb2", "nmb3"))
      nmb <- nmb[, maxj := apply(nmb[, .(nmb1, nmb2, nmb3)], 1, which.max)]
      nmb <- nmb[, maxj := factor(maxj, levels = c(1, 2, 3))]
      nmb
      #}
    }})
  
  output$ceaca2<-renderText({
    
    if(input$data_filter=='Upload_dataset'){
      # if(input$ceaca11){
      HTML("<p>The \"nmb1\", \"nmb2\", and \"nmb3\" columns represent the NMB values for strategy 1, strategy 2, and strategy 3, respectively.
             The \"maxj\" column indicates the strategy with the highest NMB for each sample.</p>")
      #}
    }})
  
  output$ceaca3<-renderPrint({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$ceaca11){
      filtered_df <- setDT(filtered_df)
      ktop <- 200000
      cea_pw_out <-  cea_pw(filtered_df,  k = seq(0, ktop, 500), comparator = "Strategy 1",
                            sample = sample, strategy = strategy, grp =grp,
                            e = qalys, c = cost)
      filtered_df <- filtered_df[, nmb := 50000 * qalys - cost]
      random_rows <- sample(1:n_samples, 10)
      nmb <- dcast(filtered_df[sample %in% random_rows & grp == "Group 2"], 
                   sample ~ strategy, value.var = "nmb")
      setnames(nmb, colnames(nmb), c("sample", "nmb1", "nmb2", "nmb3"))
      nmb <- nmb[, maxj := apply(nmb[, .(nmb1, nmb2, nmb3)], 1, which.max)]
      nmb <- nmb[, maxj := factor(maxj, levels = c(1, 2, 3))]
      
      mce <- prop.table(table(nmb$maxj))
      mce
      # }
    }})
  
  output$ceaca4<-renderText({
    
    if(input$data_filter=='Upload_dataset'){
      # if(input$ceaca11){
      HTML("<p>It calculates the proportion of times that each treatment strategy has the highest Net Monetary Benefit (NMB). 
             Treatment strategy 3 appears to have the highest NMB most frequently, followed by treatment strategy 2.</p>")
      #}
    }})
  
  ceaca5<-reactive({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$ceaca11){
      
      ktop <- 200000
      cea_out <-  cea(filtered_df, k = seq(0, ktop, 500), sample = sample, strategy = strategy,
                      grp = grp, e = qalys, c = cost)
      
      plot_ceac(cea_out)
      #}
    }})
  
  output$ceaca5 <- renderPlot({
    ceaca5()
  })
  
  ceafa2<-reactive({
    filtered_df <- filtered_data()
    sample <- input$sampleVariable
    strategy <- input$strategyVariable
    grp <- input$groupVariable
    cost <- input$costVariable
    qalys <- input$qalysVariable
    if(input$data_filter=='Upload_dataset'){
      #if(input$ceafa11){
      
      ktop <- 200000
      cea_out <-  cea(filtered_df, k = seq(0, ktop, 500), sample = sample, strategy = strategy,
                      grp = grp, e = qalys, c = cost)
      
      plot_ceaf(cea_out)
      # }
    }})
  
  output$ceafa2 <- renderPlot({
    ceafa2()
  })
  output$dec_analysisaa2<-renderText({
    if(input$data_filter=='Upload_dataset'){
      #if(input$decision_analysis){
      HTML("<p>The output provides a summary of the decision analysis performed within a cost-effectiveness analysis (CEA) framework.</p>
        <p>The summary includes information on the mean effectiveness (e_mean) and mean costs (c_mean) for each treatment strategy and subgroup.
           It also provides the lower (e_lower, c_lower) and upper (e_upper, c_upper) bounds of the confidence intervals for effectiveness and costs.</p>
           <p>The $mce component of the output provides the probability of each treatment strategy being the most cost-effective option for each 
           subgroup at different willingness-to-pay (WTP) values. It indicates which treatment strategy is the best (best) at each WTP value.</p>
           <p>The $evpi component provides the expected value of perfect information (EVPI), which represents the maximum amount that decision makers 
           would be willing to pay for perfect information about the most cost-effective treatment strategy. It also includes the lower (enmbci) and
           upper (enmbpi) bounds of the confidence intervals for the expected net monetary benefit (ENMB) associated with each treatment strategy and subgroup.</p>
           <p>The $nmb component provides the expected net monetary benefit (ENMB) associated with each treatment strategy and subgroup at different WTP values. 
           It also includes the logarithm of the net monetary benefit (LNMB) and the uncertainty in the net monetary benefit (UNMB) for each strategy and subgroup.</p>")
      # }
    }})
  
  output$dec_analysisaa4<-renderText({
    if(input$data_filter=='Upload_dataset'){
      # if(input$decision_analysis){
      HTML("<p>The output provides a summary of the pairwise analysis comparing two treatment strategies (Strategy 2 and Strategy 3) to a comparator (Strategy 1).</p>
      <p>Summary: The summary section provides the mean values for the incremental effectiveness (ie_mean), incremental cost (ic_mean), and incremental cost-effectiveness ratio (ICER) for each strategy and group. It also includes the lower and upper bounds for the
      incremental effectiveness (ie_lower and ie_upper) and incremental cost (ic_lower and ic_upper).</p>
        <ul><li>The ie_mean represents the average difference in effectiveness between the two treatment strategies and the comparator. A positive value indicates that the strategy is more effective, while a negative value indicates it is less effective</li>
        <li>The ic_mean represents the average difference in cost between the two treatment strategies and the comparator. A positive value indicates that the strategy is more costly, while a negative value indicates it is less costly.</li>
        <li>The ICER represents the incremental cost per unit of effectiveness gained. It is calculated by dividing the incremental cost by the incremental effectiveness. A lower ICER indicates better value for money.</li></ul>
           <p>Delta: The delta section provides the incremental effectiveness (ie) and incremental cost (ic) for each combination of strategy, group, and sample. This can be used to further analyze the differences between the strategies.</p>
           <p>CEAC: The CEAC section provides the probability (prob) that each strategy is cost-effective compared to the comparator at different willingness-to-pay thresholds (k). It shows how the probability changes as the willingness-to-pay threshold increases.</p>
           <p>INMB: The INMB section provides the incremental net monetary benefit (INMB) for each strategy, group, and willingness-to-pay threshold (k). It includes the expected INMB (einmb), lower INMB (linmb), and upper INMB (uinmb). The INMB represents the monetary 
           value of the incremental health benefits gained from a strategy compared to the comparator, considering the willingness-to-pay threshold.</p>")
      # }
    }})
  
  output$icera3<-renderText({
    if(input$data_filter=='Upload_dataset'){
      #if(input$icer){
      HTML("<p>Group: The group column indicates the specific group for which the ICER is calculated.</p>
      <p>Outcome: The outcome column specifies the measure for which the ICER is calculated. In this case, it is incremental QALYs, incremental costs, incremental net monetary benefit (NMB), or the ICER itself.</p>
      <p>Strategy 2 and Strategy 3: The Strategy 2 and Strategy 3 columns show the ICER values for each strategy compared to the comparator.</p>
        <ul><li>Incremental QALYs: This measure represents the average difference in quality-adjusted life years (QALYs) gained between the strategy and the comparator. The values are presented with their corresponding 95% confidence intervals.</li>
        <li>Incremental costs: This measure represents the average difference in costs between the strategy and the comparator. The values are presented with their corresponding 95% confidence intervals.</li>
        <li>Incremental NMB: This measure represents the incremental net monetary benefit, which considers both the incremental QALYs and incremental costs in monetary terms. The values are presented with their corresponding 95% confidence intervals.</li>
        <li>ICER: This measure represents the incremental cost per QALY gained when comparing the strategy to the comparator. It is calculated by dividing the incremental costs by the incremental QALYs. The ICER value is presented without confidence intervals.</li></ul>
             ")
      #  }
    }})
  
  output$cepaa4<-renderText({
    if(input$data_filter=='Upload_dataset'){
      # if(input$cep){
      HTML("<p> The plot is a cost-effectiveness plane that shows the incremental effectiveness (in terms of QALYs) 
             of a treatment strategy relative to a comparator, plotted against the incremental cost of the treatment strategy. </p>
             <p>The x-axis represents the incremental QALYs, which is the difference in QALYs between the treatment strategy and the comparator. 
             The y-axis represents the incremental costs, which is the difference in costs between the treatment strategy and the comparator.</p>
             <p>The dotted line in the plot is the Willingness-to-Pay (WTP) line, which represents the threshold of cost-effectiveness. The slope of the WTP line is
             equal to the value of \"k\". Points below the WTP line are considered cost-effective, indicating that the treatment strategy provides good value for money. 
             Points above the WTP line are not considered cost-effective.</p>
             <p>the points above the dotted line represent treatment strategies that have higher incremental costs and lower incremental QALYs compared to the comparator. 
             These strategies are generally not considered cost-effective. On the other hand, points below the dotted line represent treatment strategies that 
             have lower incremental costs and higher incremental QALYs compared to the comparator, making them cost-effective.</p>
             ")
      #}
    }})
  
  
  output$downloadPlot7 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(cepa3())
      dev.off()
    }
  )
  
  
  output$downloadPlot8 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(ceaca5())
      dev.off()
    }
  )
  
  output$downloadPlot9 <- downloadHandler(
    filename = function() { "output.pdf" },
    content = function(file) {
      pdf(file, paper = "default")
      plot(ceafa2())
      dev.off()
    }
  )
}


#_______________________________________________________________________________________________________________________


shinyApp(ui=ui, server=server)





