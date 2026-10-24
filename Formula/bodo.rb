# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1024.4352/bodo-darwin-arm64"
  version "2026.1024.4352"
  sha256 "62483056262e6ad0319e1983f95572ab9581e36a4b933ed17cbf82a6133f2be9"
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
      url "https://cli.bodo-app.com/v/2026.1024.4352/bodo-linux-arm64"
      sha256 "ec0d86d2e5cdaaf68259af353585c76b4c35255ca035b8a39a89a9672f02ea9e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1024.4352/bodo-linux-x64"
      sha256 "9dd49825feb5c76a6c270b9a4287b47f853111e8240e92ba4669e72fa3090ac2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
