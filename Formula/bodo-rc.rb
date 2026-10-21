# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4172-rc/bodo-darwin-arm64"
  version "2026.1021.4172-rc"
  sha256 "82227ee8b66ed416f958b72b57bd0fb3486fbe52ed7d3bff7499799ed8595868"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1021.4172-rc/bodo-linux-arm64"
      sha256 "e1b9d9ce9fc13fac372675fb6aaf117d7b0e59f3651a5d4455bd52e24a5d5d6c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4172-rc/bodo-linux-x64"
      sha256 "0f64f691cbdc228243b578fdbf81132dc47d4fbf9fb72e5ce2c442eda5857510"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
