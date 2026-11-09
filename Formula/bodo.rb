# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1109.4714/bodo-darwin-arm64"
  version "2026.1109.4714"
  sha256 "67d171c90cf58f00ab65a0f93a9f6a4f6637e87717f0e0d0066a0eea91420efa"
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
      url "https://cli.bodo-app.com/v/2026.1109.4714/bodo-linux-arm64"
      sha256 "1724ad9027c3e2b19c2e53602091b7373b69df8776ab046e2d212fce9d4596cf"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1109.4714/bodo-linux-x64"
      sha256 "344b4c081de33471fb4a6537dc19b660c89b222bb8c55a7a5889114478405313"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
