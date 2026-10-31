# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1031.4684/bodo-darwin-arm64"
  version "2026.1031.4684"
  sha256 "feaea9eaa967dde3e23d9f59abd5bccc63ad1f11bd718af8a5a3629e734d3c53"
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
      url "https://cli.bodo-app.com/v/2026.1031.4684/bodo-linux-arm64"
      sha256 "e63cc2dae25307445f627483dd56fde007a330602fd4be7c4f344c56d1e88fe7"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1031.4684/bodo-linux-x64"
      sha256 "4f1e8adaa0f874e275e5a8544c29f9e390c2216bc4929272e914c04d1caa9871"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
