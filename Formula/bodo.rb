# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1126.4767/bodo-darwin-arm64"
  version "2026.1126.4767"
  sha256 "bdeae84f03d23800c5e24c864eda6e5f6ff7d9457118576ed9fa4ad1f5f01091"
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
      url "https://cli.bodo-app.com/v/2026.1126.4767/bodo-linux-arm64"
      sha256 "40be8211fbff68517d0c43e5d5929c924365b02288631419d21835fe1afcbdb4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1126.4767/bodo-linux-x64"
      sha256 "a097c78c1df8e1fb9ad36b5c08af6d8727a2626498869a3b8934ed398b6e2550"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
