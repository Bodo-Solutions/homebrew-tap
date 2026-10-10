# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3822/bodo-darwin-arm64"
  version "2026.1010.3822"
  sha256 "73deeb836037ba7b884f1512ef4bc12aa02d3637c584241051d19708dd17775d"
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
      url "https://cli.bodo-app.com/v/2026.1010.3822/bodo-linux-arm64"
      sha256 "59c36e7ba48f9b52513c23cb862594ec13389528072e79d07e4cd5db1eab79c1"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3822/bodo-linux-x64"
      sha256 "8ff810233a6bd5e619df28cfa99d1b06274a2d31a51a519c1dc34c9653e0e6c5"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
