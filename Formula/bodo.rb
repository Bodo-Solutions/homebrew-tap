# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1115.4735/bodo-darwin-arm64"
  version "2026.1115.4735"
  sha256 "3fb5be64987ebbccbde5a3a8ffd9174e7729ebddc830beab87890e6c83820acf"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1115.4735/bodo-linux-arm64"
      sha256 "48c3e25681612f6ec3c159e60974b02726a61ee7947d2006d26a7d39f1790135"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1115.4735/bodo-linux-x64"
      sha256 "473b6353098e5026e150f90b73acb0f8390419fc4142e809aa716c42d706bd74"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
