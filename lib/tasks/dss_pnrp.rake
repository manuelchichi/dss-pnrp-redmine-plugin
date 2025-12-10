namespace :dss_pnrp do
  desc "Load DSS-PNRP demo/init data"
  task load_demo: :environment do
    require_relative '../dss_pnrp/inits_loader'  # adjust path if needed
    DssPnrp::InitsLoader.run
    puts "DSS-PNRP demo data loaded."
  end
end