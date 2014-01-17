packages = Array.new

case node[:lsb][:codename]
when "lucid"
  packages |= %w/
    libssl0.9.8
  /
when "precise"
  packages |= %w/
    libssl1.0.0
  /
end

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end
