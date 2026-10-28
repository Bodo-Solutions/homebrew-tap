# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4519/bodo-darwin-arm64"
  version "2026.1028.4519"
  sha256 "51827c356df083d73061cc64d68b76988354521601023e964a28b757d383fd70"
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
      url "https://cli.bodo-app.com/v/2026.1028.4519/bodo-linux-arm64"
      sha256 "b2cb74e9c5a2809b5c1762c082a047c7f355bf54ea5aa11f3c81e0050fc6f9de"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4519/bodo-linux-x64"
      sha256 "44ce3954c802a5765d494504b54fafb4cd50e1e0c35c8002271ce3adbb3542b5"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
