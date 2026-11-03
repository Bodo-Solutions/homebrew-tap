# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1103.4693/bodo-darwin-arm64"
  version "2026.1103.4693"
  sha256 "feee1df15a66ecb53eb509666ab5e3508f39d7ee26459d325ce9bcb4ac74a125"
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
      url "https://cli.bodo-app.com/v/2026.1103.4693/bodo-linux-arm64"
      sha256 "0f1c73e2c119c15399ec3aa99ec4c5c7227dfbe9f11fe4491dcddc372d4d5cac"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1103.4693/bodo-linux-x64"
      sha256 "687ad734206da8299d8a3e13d818f9f633f99d49ce040b56348b0a4469f0ca04"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
