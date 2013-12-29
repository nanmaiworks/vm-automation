include_recipe "libssl"

packages = Array.new

case node[:lsb][:codename]
when "lucid"
  packages |= %w/
    wget
  /
when "precise"
  include_recipe "libidn"

  packages |= %w/
    wget
  /
end

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end
