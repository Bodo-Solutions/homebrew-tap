# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1109.4715/bodo-darwin-arm64"
  version "2026.1109.4715"
  sha256 "c53f319978d7b188f4bc4d0c44a36bb9994ad6f02cdd159ed23d0e16eca4a2f4"
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
      url "https://cli.bodo-app.com/v/2026.1109.4715/bodo-linux-arm64"
      sha256 "e8b1471d6df81a224d51d014e946f8bee8be82cd9f6202ad1107e30063ed98e4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1109.4715/bodo-linux-x64"
      sha256 "1d184ff4aae55d699936a2b4ed990efd4e52288c9e8ca8eb0a5579cddabb1659"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
