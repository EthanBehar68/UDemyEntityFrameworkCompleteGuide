﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'UDemyCodeFirstVidzy.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '202003091727216_AddVideoAndGenreTables'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [tinyint] NOT NULL,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [ReleaseDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [tinyint] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202003091727216_AddVideoAndGenreTables', N'UDemyCodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400DD59DB6EE336107D2FD07F10F4D416592B97976D60EF22EB2445D0CD057112F42DA0A5B14394A254920AEC2DFA657DE827F5173AD45D2465CBD945B62D02043639339CCBE15CE8BFFFFC6BFC7E1533EF1984A4099FF807A37DDF031E2611E5CB899FA9C59BB7FEFB77DF7E333E8BE295F750D11D693AE4E472E23F29951E07810C9F20267214D350243259A85198C4018992E0707FFFC7E0E0200014E1A32CCF1BDF665CD118F22FF8759AF010529511769944C064B98E3BB35CAA77456290290961E2DF9F42BC9E22D93915523DD0E8D3DAF74E1825A8CA0CD8C2F708E789220A153DBE97305322E1CB598A0B84DDAD5340BA0561124A038E1BF2A1B6EC1F6A5B8286B11215665225F18E020F8E4AE70426FB8B5CECD7CE43F79DA19BD55A5B9DBB70E2FF045CA0E5E649C753263495D3BDA39C69CF736CEDD59040E4E8BF3D6F9A3195099870C894206CCFBBC9E68C863FC3FA2EF915F884678CB575442D71AFB3804B37224941A8F52D2C4ACD2F22DF0BBA7C81C958B3B5780AB33EAC159A7D85679339831A01C14676FDBF128030C22BE17B9764F511F8523D4D7CFCE87BE7740551B5524ABDE7146F10322991D9875C9167BACCBD6E1C871E8544FADE2DB07C5B3ED1B4C0F428DF7ACCE38004E722896F1356B194EB8F77442C41A1C2896373966422349419070D3E36A22697B42B6A72A6FF366A2EB83A3A74C0A6E582994A04A08F411005D10D510A04D7322077E2D781987108020A888453A2EAB3F4E73B1A0FB813BD70ADD0F852B8568874C2B5C2F210B89E48998434D7A18DD7EAFCAE39673CF236295344A23602A381C8A42962114F9EF83F58FEE911585FC64660997B370A1C072D6BEC3B898552118A606B0CFDB43E9DEB655829C70DC502585E525962C5D45E8B9D813282DA78BAABBC657C97BD4A61167BE94C83BD65AB21A3064F8BC4052E33036C096FAD6FA36A30504415D096884A4733C174CD7220B80E63D3E80445A7537544414F4B34BE24698A59A2D522952BDEACE88FA66F66BBF70D71212308A5A37DA8B5AD4FC29C479660ECE2D15596C7EC42E644279369145B6406687B10551DD6C1A51DAB0A6715B9FE5CB0F47632A694C687E768568C893BB710CC48DB7C79834A18118E0A324D5816F3BE2AB489BBA8096DFE62C596300E0CC54DFF0496830CA89AEE1E148CF2EA7C6E308A9CB07B307AF8BE7630FA2474AA6F5B5067E3F583DBCD528E08D7397840186B5A67B09CD747275A57076CE46CDB2F83A25C8872C55AFBA53E78479DCA22F0429D72213BEA6456133B94565131496A20D5C5C52822E332A16F1FBEAD0C5F90F81EEAFE8C8EC2EC3E5B4B05F148138C66BFB129A308DD86E09270BA00A98AB6DEC7F1F7D018DFFF3DA3742065C486CCD3AF3E9828CAD754BBF533265AFE4C44F844C47731597DDF96648F143B0E8AAFEE8EDC155B27B1D7F1D5A0F12BC2CF6AFBF8B59BDF5F8CC50DB9D226EE4B62DBE3D51CD38A9A35B15CF0085613FFF79CE9D8BBF8E5B1E2DBF3AE056690636FDFFB63E768366A1B3768800215EF0E0ABC6C5675D63C7320D93EA41E58A5F69A9F220815782761914CA7448624B2BDA6EBD0C6D3CB39D05461C86CABDF7D610142DF47C2B05C4925B060597DCD8DA03CA429611DABED9A3B248B68936A79E6CE29A4C0757AB00D1C72DAA616A3166DB8779B037AE7FF2DC0713526ADD0D9517306EC7F069CE1A17C5DE06CEA03BF3870DC0F47F6A83EE05DA8FF59A86803B1AECD757A2AB262CFEB88F3C9A8FFC5C825D9FD74E396DCA7787BB3F78C1E13B63E5BD5EF4D9B5FAF7A461C3BE15BC3EFD657AB8ED9E62036FCC16A90B1D5CBD81663DDB3939DA4AC6797D7327687D7397B60C21BDAFA4D133384A4CB4684FE859343D8B99B35CD055F2455923034AA488C66E61214C116929C0845172454B81D8294F9AF070F8465487216CF21BAE0D7994A338526433C679D5F2374AAD9747EFE04D9D5797C9DE60FFD5FC2045493EA2EF89A7FC8288B6ABDCF1DBD548F089DC3CA7E5FC752E9BE7FB9AE255D257CA0A0D27D75EABD833865284C5EF319798697E8762FE1232C49B8AEE6DE7E21DB03D175FBF89492A520B12C6534FCF815311CC5AB77FF00B8C8D7CEDA1F0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202003091740149_PopulateGenreTable'
BEGIN
    INSERT INTO Genres (Id, Name) VALUES ('1', 'Comedy')
    INSERT INTO Genres (Id, Name) VALUES ('2', 'Action')
    INSERT INTO Genres (Id, Name) VALUES ('3', 'Horror')
    INSERT INTO Genres (Id, Name) VALUES ('4', 'Thriller')
    INSERT INTO Genres (Id, Name) VALUES ('5', 'Family')
    INSERT INTO Genres (Id, Name) VALUES ('6', 'Romance')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202003091740149_PopulateGenreTable', N'UDemyCodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400DD59DB6EE336107D2FD07F10F4D416592B97976D60EF22EB2445D0CD057112F42DA0A5B14394A254920AEC2DFA657DE827F5173AD45D2465CBD945B62D02043639339CCBE15CE8BFFFFC6BFC7E1533EF1984A4099FF807A37DDF031E2611E5CB899FA9C59BB7FEFB77DF7E333E8BE295F750D11D693AE4E472E23F29951E07810C9F20267214D350243259A85198C4018992E0707FFFC7E0E0200014E1A32CCF1BDF665CD118F22FF8759AF010529511769944C064B98E3BB35CAA77456290290961E2DF9F42BC9E22D93915523DD0E8D3DAF74E1825A8CA0CD8C2F708E789220A153DBE97305322E1CB598A0B84DDAD5340BA0561124A038E1BF2A1B6EC1F6A5B8286B11215665225F18E020F8E4AE70426FB8B5CECD7CE43F79DA19BD55A5B9DBB70E2FF045CA0E5E649C753263495D3BDA39C69CF736CEDD59040E4E8BF3D6F9A3195099870C894206CCFBBC9E68C863FC3FA2EF915F884678CB575442D71AFB3804B37224941A8F52D2C4ACD2F22DF0BBA7C81C958B3B5780AB33EAC159A7D85679339831A01C14676FDBF128030C22BE17B9764F511F8523D4D7CFCE87BE7740551B5524ABDE7146F10322991D9875C9167BACCBD6E1C871E8544FADE2DB07C5B3ED1B4C0F428DF7ACCE38004E722896F1356B194EB8F77442C41A1C2896373966422349419070D3E36A22697B42B6A72A6FF366A2EB83A3A74C0A6E582994A04A08F411005D10D510A04D7322077E2D781987108020A888453A2EAB3F4E73B1A0FB813BD70ADD0F852B8568874C2B5C2F210B89E48998434D7A18DD7EAFCAE39673CF236295344A23602A381C8A42962114F9EF83F58FEE911585FC64660997B370A1C072D6BEC3B898552118A606B0CFDB43E9DEB655829C70DC502585E525962C5D45E8B9D813282DA78BAABBC657C97BD4A61167BE94C83BD65AB21A3064F8BC4052E33036C096FAD6FA36A30504415D096884A4733C174CD7220B80E63D3E80445A7537544414F4B34BE24698A59A2D522952BDEACE88FA66F66BBF70D71212308A5A37DA8B5AD4FC29C479660ECE2D15596C7EC42E644279369145B6406687B10551DD6C1A51DAB0A6715B9FE5CB0F47632A694C687E768568C893BB710CC48DB7C79834A18118E0A324D5816F3BE2AB489BBA8096DFE62C596300E0CC54DFF0496830CA89AEE1E148CF2EA7C6E308A9CB07B307AF8BE7630FA2474AA6F5B5067E3F583DBCD528E08D7397840186B5A67B09CD747275A57076CE46CDB2F83A25C8872C55AFBA53E78479DCA22F0429D72213BEA6456133B94565131496A20D5C5C52822E332A16F1FBEAD0C5F90F81EEAFE8C8EC2EC3E5B4B05F148138C66BFB129A308DD86E09270BA00A98AB6DEC7F1F7D018DFFF3DA3742065C486CCD3AF3E9828CAD754BBF533265AFE4C44F844C47731597DDF96648F143B0E8AAFEE8EDC155B27B1D7F1D5A0F12BC2CF6AFBF8B59BDF5F8CC50DB9D226EE4B62DBE3D51CD38A9A35B15CF0085613FFF79CE9D8BBF8E5B1E2DBF3AE056690636FDFFB63E768366A1B3768800215EF0E0ABC6C5675D63C7320D93EA41E58A5F69A9F220815782761914CA7448624B2BDA6EBD0C6D3CB39D05461C86CABDF7D610142DF47C2B05C4925B060597DCD8DA03CA429611DABED9A3B248B68936A79E6CE29A4C0757AB00D1C72DAA616A3166DB8779B037AE7FF2DC0713526ADD0D9517306EC7F069CE1A17C5DE06CEA03BF3870DC0F47F6A83EE05DA8FF59A86803B1AECD757A2AB262CFEB88F3C9A8FFC5C825D9FD74E396DCA7787BB3F78C1E13B63E5BD5EF4D9B5FAF7A461C3BE15BC3EFD657AB8ED9E62036FCC16A90B1D5CBD81663DDB3939DA4AC6797D7327687D7397B60C21BDAFA4D133384A4CB4684FE859343D8B99B35CD055F2455923034AA488C66E61214C116929C0845172454B81D8294F9AF070F8465487216CF21BAE0D7994A338526433C679D5F2374AAD9747EFE04D9D5797C9DE60FFD5FC2045493EA2EF89A7FC8288B6ABDCF1DBD548F089DC3CA7E5FC752E9BE7FB9AE255D257CA0A0D27D75EABD833865284C5EF319798697E8762FE1232C49B8AEE6DE7E21DB03D175FBF89492A520B12C6534FCF815311CC5AB77FF00B8C8D7CEDA1F0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202003091757020_AlterGenresColumnInVideoTableToGenreColumn'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [tinyint]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202003091757020_AlterGenresColumnInVideoTableToGenreColumn', N'UDemyCodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400D559D96EE336147D2FD07F10F4D416192BCBCBD4B067907192C2E8644194047D0B68E9DA214A512A4905D614FDB23EF493FA0BBDD42E5276644F27D32240E090BC877739BC8BF3F79F7F4DDEAF23E63C839034E653F76874E83AC08338A47C357553B57CF3D67DFFEEDB6F26E761B4761EAA7327FA1C4A7239759F944AC69E27832788881C453410B18C976A14C49147C2D83B3E3CFCD13B3AF200215CC4729CC96DCA158D20FF03FF9CC53C8044A5845DC6213059AEE38E9FA33A572402999000A6EEFD1944D90C8F5D5021D5030D3F65AE73CA2841557C604BD7219CC78A2854747C2FC15722E62B3FC105C2EEB204F0DC923009A501E3E6F8505B0E8FB52D5E23584105A95471B423E0D149E91CCF14DFCBC56EED3C74DF39BA5965DAEADC8553F727E0022D376F1ACF98D0A77ADD3BCA850E9C9EAD839A12C81CFD73E0CC52A65201530EA912841D3837E982D1E067C8EEE25F814F79CA585B47D412F73A0BB87423E20484CA6E61596A3E0F5DC7EBCA79A6602DD69229CCFA902934FB0AEF260B063503BCADE2FA77058034C227E13A9764FD11F84A3D4D5DFCE83A17740D61B552A2DE738A2F08859448ED4BAEC8335DE55E37AE438F422C5DE71658BE2D9F6852707A946F3D96C1BB1071741BB34AA2587EBC2362050AD58DED3D3F4E45606832F11A726CA54C0EB42B6572A1FF3765E65C9D1CF770A6E5025FC502D0C5208882F0862805826B0CC89DF875F8655C826C0222E18CA8FA2EFDF98E46031EC446AE9654DC8FAA151DFBA85AD17808554FA58C039A2BD0E66A7979D792731E3A5B34296250EB8F71404ED2045988F74EDD1F2CCFF4E3D58FB0C12B3DD1C53B1C8D8E4C1B5BD6D8EF112BA4221489D618FA293B5BE86558AB9ED78995AF7CA0B2E489A9BF86F541B5038AC9A7F174577FCBFCAE7895BB2CF1D29D8678CB5603A3624EEB440FB1CCB7BF3DBAB5B28D9EDE30842A9E2D84CA516662E99AD4C3DE3A844D77E315ED4DD506791BFAA0C9254912CC0EADBEA85C71FCA2299ABDF1776F16A202C30B644FCF506B5BDF84B98EACC0D8C5ABABEC8E59852C884E22B330B28E1984DDC0A6EAB20E27ED50551CAB8EEBCF85C8C6F6C544697C7881664598B0730BC18CB42D9777A58411D1533966314B23BEA9FA6C932E6A415BBE58B111269EA1B8E91FCF72904155D3DD838251BE9CCF0D46910F760FC606B9AF1D8C4D089DAADB06EA6CBC7E70BB59AA27C255FE1D10C5EAE8A050E904DBD7EF7613ADED8F41D12D30FA62ACFD51DFBB9B4A65F5D853A59D95C1CC18D2BC95994BDD96D52DD91043CDF263C7DEAA42E6919A79753532AACEA4AC002F8FE85649288EB80EDAFE8C1EC672E067524134D20746FE6F6CC62872BD397049385D825445FFEFE2907C6C0CF9FF9D81DB93326443A6EE579F6014E519D56EFD8CB9973F13113C11F15D44D6DFB791ECD963C789F2D5DD91BBE2C591ED757C35684E0BF1B31A34A7F54D678F3D44B0C684390F613D757FCF05C7CEFC97C74AF6C0B916F812C7CEA1F3C77E71DF6F3C6BD59FDD2628BB89DF67AE43B281D05C200C53A5540293A555846F70560F6842584767BB520C61B0F65F8D67EE9C41025C53B363D6908BB695C41AD5784A2FD9BEE38C6A4F060346D0CD13685144F0552C74600B326E18C67AA7D3CDC3691F72FFA0F80507D78EF5ADF9E3C551D59E6FBFCC706A977F644CEB7B7C24ABA4AB064277341C820E57EA3373BE8C2BD21A1A55478C9C76098A604224A742D12509146E072065FEA5D90361291E398F1610CEF975AA9254A1C9102D58E74B384DFD6DF7E7137857E7C975927FC1F56F98806A529DD3AFF98794B2B0D6FBC2CEE99B20F49B2AAB978EA5D2556C95D54857311F0854BAAF4E057710250CC1E435F7C933ECA3DBBD848FB022415675719B415E0E44D7ED93334A568244B2C468E4F5FFA63CFDCFA977FF00F75C007FCE1A0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202003091800260_AddClassificationEnumToVideoTable'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [int] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202003091800260_AddClassificationEnumToVideoTable', N'UDemyCodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400D559CD6EE33610BE17E83B083AB545D6B2934B1BD8BBD8759285D175124449D05B404B63872845A92415D82DFA643DF491FA0A1DEA5FA4ECC8DE6CB6C5020B8B9C19CE0CBFF963FEF9EBEFF1BB75C49C271092C67CE28E0643D7011EC421E5AB899BAAE59B1FDD776FBFFD667C1E466BE7BEA43BD174C8C9E5C47D542A39F53C193C4244E420A2818865BC5483208E3C12C6DEF170F893371A7980225C94E538E39B942B1A41F6819FD3980790A894B0791C0293C53AEEF89954E79244201312C0C4BD3B83683345B20B2AA4BAA7E1EF1BD779CF2841557C604BD7219CC78A2854F4F44E82AF44CC577E820B84DD6E1240BA2561120A034E6BF2BEB60C8FB52D5ECD588A0A52A9E2684F81A393C2399EC97E908BDDCA79E8BE7374B3DA68AB33174EDC8FC0055A6E9E743A65425375BA7790311D391D5B4715241039FADF91334D994A054C38A44A1076E45CA70B46839F61731BFF0A7CC253C69A3AA296B8D75AC0A56B112720D4E6069685E6B3D075BC369F6732566C0D9EDCAC0F1B85665FE2D964C1A04280B7935DFF5F0A40186148B8CE9CAC3F015FA9C7898B3F5DE782AE212C570AA9779C6204219312A97DC82579A2ABCCEBC671E85188A5EBDC00CBB6E5234D724C0FB2AD87E2F22E441CDDC4ACE4C8971F6E8958814275637BCF8F5311189A8CBD1A1C3B219309DA173219D3FF1B3233AE4E8E3B30D37081AF6201E862104441784D9402C1B50CC89CF875F0651C82680222E18CA8EA2CFDFB9646FB07C4941129E99206457A2A54D70835B79E93BC350A0A901F160425D0BB82A00C907E4190468D10308D9BC90B46567521D92F36DAD25E3448101A2108B641283541DC76FD1CA20588C2349F32ACFEAE734F588A9F23EBA25AD41F631656B4C7BB69AFF505A21F2BFA13DBF7B9979B8BEFA58C039A79A6997F8A6B6F1F77CE436707066A7016296C8E2EA4093A0D6F7CE2FE60A9DF2DAF4AACB5BC02836D79C3C160645AD8B0C6CEB1D8F5284279E5B0ECE6CF167A19D6AA0355D8CD14C09245EC9BFA6BB13EA866286141A931DED6DF32BFCD5ED6238BBD70A7C1DEB0D59051C66C83A223A4CD7CBEFB762B656B3DBD7E12CAFB6C48281D65168BB6491D79A3BAC2BA63F5F296B56C6DBD2DBDED784E9204C3B4D1EB162B8E9F37BAD337FEFE0D6094CBF002D9D10756DA562761FD222B3076F1E8321961A5200BA253DC348C2C3203B05BD0541ED6C2A47D5525C64A72FD3B67D9DA929A526A1F5EA0591116E1CC42306FDAE6CB260DC288E8E806A6314B23BEADA3D8C59DD7F7267FBE624B187B86E2A67F3CCB4106544D77F7BA8C22723EF732F27CB0FF656CE1FBDA97B14D42AB936A0A6A6DF4976776154D91E6DEEB43A69DFB3A705366F51ED828497B0140A7EDAEC9A89DBE6D7FF4C24C2EA30B39DA1FD5B9FBA954D4A40355DA5B19CCB721CD1AA499D46D76D586F631D42C6AF6DD5BB5CD24A99057D538A3968D8BBAF2FC638E55687212D741DB9FD0C35864FC8D54100D34C1C0FF8D4D1945ACD70473C2E912A4CA9B60F778383A369E83FE3B4F339E9421EBF33EF3EAB32E36EA3833A8CF7A21E14F44048F447C1791F5F74D49F694BAE7DBC3ABBB2373C5B3C3FDEBF8AAD7441FE26FF57213FD2150A8138E01296B8C99E18CBA9EB87F648CA7CEEC978792F7C8B91218D3A7CED0F9F330041D363E362AD97E139E3D641C3277226C41685411864957E2784FED727E2D280F6842584B67BBE6F48905EDBF4A9EB9730609700DF296597D0EDA555C2BA946503E67FB9E33B43DB9F41891B74FC87939C2F85AE88BCDC1B86558EC9C9EB70FCF5D92BB07D92F3858B7AC6FCC47CF8ED2F6FCFD658667BB9140C434FE7684609574558BD0BD1187A085958A66C69771095A43A392C4C869735004532B792F145D9240E17600982FF5436DF1A8751E2D209CF1AB5425A94293215AB0D6C3AF86FEAEF3B31782B6CEE3AB247BFA7C0913504DAAABC315FF90D2C6E3DD859DD3B789D03155D4417D974AD7C3D5A6927419F39E820AF755A9E016A284A13079C57DF20487E87627E113AC48B029FBC1ED429EBF88B6DBC76794AC04896421A3E6C74FC47018ADDFFE0B6E874C81421D0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202003092103060_VideoAndGenreTableNameRequiredRemoveUnderscoreFromGenre_Id'
BEGIN
    ALTER TABLE dbo.Videos DROP CONSTRAINT DF__Videos__Classifi__48CFD27E
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[Videos]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[Videos]
    EXECUTE sp_rename @objname = N'dbo.Videos.Genre_Id', @newname = N'GenreId', @objtype = N'COLUMN'
    ALTER TABLE [dbo].[Genres] ALTER COLUMN [Name] [nvarchar](255) NOT NULL
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [Name] [nvarchar](255) NOT NULL
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [Classification] [tinyint] NOT NULL
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [GenreId] [tinyint] NOT NULL
    CREATE INDEX [IX_GenreId] ON [dbo].[Videos]([GenreId])
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202003092103060_VideoAndGenreTableNameRequiredRemoveUnderscoreFromGenre_Id', N'UDemyCodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400D559CD6EE33610BE17E83B083A16592B76B0401BD8BBC83AC9C2E83A09A224E82DA0A5B14394A254920AEC2DFA643DF491FA0A1D4A942C5192633B3FDD4580C026673E9233DF0C67E87FFFFE67F8711931E71184A4311FB9FDDEA1EB000FE290F2C5C84DD5FCDDCFEEC70F3FFE303C0BA3A57357C81D6939D4E472E43E28951C7B9E0C1E2022B217D140C4329EAB5E10471E09636F7078F88BD7EF7B80102E6239CEF03AE58A46907DC1AFE3980790A894B0691C0293661C67FC0CD5B92011C8840430726F4F215A8D51EC9C0AA9EE68F875E53A278C12DC8A0F6CEE3A84F35811851B3DBE95E02B11F3859FE0006137AB04506E4E98047380E3B5F8B667391CE8B3786BC5022A48A58AA31D01FB47C6389EADBE9789DDD27868BE3334B35AE95367261CB99F810B3CB9BDD2F198092DD56ADE5EA674E0B44C1D949440E6E8BF03679C32950A1871489520ECC0B94A678C06BFC2EA26FE1DF888A78C55F788BBC4B9DA000E5D893801A156D730373B9F84AEE3D5F53C5BB154ABE8E4C7FAB45278EC0B5C9BCC18940CF036AAEBFF0500D20843C275A664F905F8423D8CDCC1FBF7AE734E9710162306F596538C20545222DD62D50BF24817991BACF5D1C4104BD7B906964DCB079AE424EF6553F7C69BE7228EAE635668E4C3F737442C40E1FEE3E69C1FA722B07632F4D66CD9C8A10C68570E654ADF3787265C1D0D5ADC593181AF6201686210444178459402C135066446FC460867AD8AF40222E194A87271FDF98646BB6365F47A66D88D199192CE696092A0B187A6BD3DB5776899C8D92FB28AE8698BAC22EAB68BAC34AAC4957DB8893C6764B1BEAE760BB83ADA8B461EF22D04C156C8CF8A9BEB969F423403614EE653862586EBDC1196E2D77EC34F35E9CF310B4BD9C166D92BED3F3463297FD4347D6EE4EAE08994714033C354739AF17A7DB9331E3A1B28B0E6A6498B53B4204DD066E8F091FB5363FBED7865B25EE3190AD6F19AA6C3EC0642A717C2B08C92E835CA553315521ED084B0EEA52D952DF3A7B670096ECF9C42025CA7BE6E036EB36A99539A4B972B5849FD29A30CBD0A059A971DEA28D428599645CBE94C0FC352B54422D6992618A549C2B6D335AC0FAA7A24BCD9D779A1EEF40667EAEA4561D050371CB4D42B67B5308A3C5791684983B6D9378744B9D9F53E1B8EDB1C041584C250F6AD5D3F524BAE2D5DB8EE25BCBC99289A0EAFA3EB184E4992606AAB742166C4F1F31664FCCEDFBD348F720C2F902D157AB9DB72252C24C802AC595CBA48E078439319D1D7C2388C1A6216613BD8542C56E364D35505C70A71FD3957E96C165AE2DA689FE3B1229D12B252C9F674532FEB010923A2A52C1BC72C8D78776AEAD6CE0BADAA7E3ED244187AD6C61B39A861208BAAB6B9B77286899CE73A23CF07BB3BA343EFFF76461742AD82AD02D526B6C72B6F9C2A56E735D48D63577455387BEE8DA9D7C893B648B97A992FADBC383439EAE9279B46D2CA455C07CDF5884CC384E5AFA482A8A7057AFE1F6CCC289E772D30259CCE41AABC08750787FD81F5E8F3ED3CC07852866C9B5798376F60B152C69A5D3DEB1D843F12113C10D16C4C3782EEF8B8F0E6A6C9CCF264F7FEF676DBAA5B0FF1B37A816EBDE447A3BE9D6091BD1CB97F667AC7CEE4B77BA37AE05C0A8CCF63E7D0F9EB851AFDED58DA45A8FD5A3B5306EFDE7D5985EC3E0DE15E0D5C5795F53A3DDB77D2A6358BE32DBAB0EE262CBFA530BC66DAAF39133BFA91D606ADBB3F6B436EEF955EB177AB9DBE52823FD9AD355BBCD7E9CF9AF50532A6F2C3117255D2C51A42FF8CC421A871A59499F0795C70D6DA51216265A729288299959C0845E72450381D00E62BFD286B1E9BCEA21984137E99AA245578648866ACF6C8ABA9BF69FDAC09ADEF797899642F922F7104DC26D597C325FF94D2CAA3DA794B3EED80D03165AE44ED4BA5AFC6C5AA44BA88F99640C67C652AB881286108262FB94F1E619FBDDD4AF8020B12AC8A32B11BE46947D4CD3E3CA5642148240DC65A1FBF2287C368F9E13F28281DB93F1D0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202003092138006_AddTags'
BEGIN
    CREATE TABLE [dbo].[Tags] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](255) NOT NULL,
        CONSTRAINT [PK_dbo.Tags] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoTags] (
        [VideoId] [int] NOT NULL,
        [TagId] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoTags] PRIMARY KEY ([VideoId], [TagId])
    )
    CREATE INDEX [IX_VideoId] ON [dbo].[VideoTags]([VideoId])
    CREATE INDEX [IX_TagId] ON [dbo].[VideoTags]([TagId])
    ALTER TABLE [dbo].[VideoTags] ADD CONSTRAINT [FK_dbo.VideoTags_dbo.Videos_VideoId] FOREIGN KEY ([VideoId]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoTags] ADD CONSTRAINT [FK_dbo.VideoTags_dbo.Tags_TagId] FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tags] ([Id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202003092138006_AddTags', N'UDemyCodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED5A6D6FDB3610FE3E60FF41D0C7218DF282025B60B7489DA408D6BC204E8A7D2B688976885194265281DD61BF6C1FF693F61776942859E28B2C39699A0E4581222679C7E3DD7377E49DFEFDFB9FD1DB654CBD079C7192B0B1BFBFBBE77B98854944D862ECE762FEEA67FFED9B1F7F189D46F1D2FB58AD3B94EB8092F1B17F2F447A14043CBCC731E2BB3109B3842773B11B267180A22438D8DBFB25D8DF0F30B0F08197E78D6E7226488C8B1FF07392B010A72247F4228930E56A1C66A60557EF12C598A728C463FFEE04C7AB092C3B2319171F49F479E57BC7942010658AE9DCF71063894002043DBAE3782AB2842DA6290C207ABB4A31AC9B23CAB13AC0D17A79DFB3EC1DC8B3046BC28A55987391C40319EE1F2AE5043AF9562AF66BE581FA4E41CD62254F5DA870ECBFC72C8393EB3B1D4D68265759D5BB5B10ED7896A99D1A12801CF96FC79BE454E4191E339C8B0CD11DEF3A9F5112FE8A57B7C9EF988D594E6953469012E65A0330749D2529CEC4EA06CF95E4E791EF056DBA4027ACC91A34E5B1DEAD041CFB12F646338A6B04049DE4F2FF8A01C0085CC2F72ED0F203660B713FF60F5EBFF6BD33B2C45135A2B8DE31021E044422CB7BEC7A891EC8A23083B63FA81827DCF76E302DA6F93D494B90EF16539F9435CFB224BE496845510E7FBA45D9020B903F31E7A6499E859A24A3608D964E0C158C8662A820FAB63174CEC4E181C59C0D154C4592615031CE90C0D1351202674CF2C085125F08E0B45D015E18717C8244BDB9FCFB96C4C37915F07AA4DB4D28E29CCC49A882A0D28784BD3EB5B56B29CFD9CEB32AEFB17956E5757D05B9458B2E0F2FA77531E4A8438A62CA26446FF7060E439D1B48BEBBF68B70EDED734907D2EC99A405C27E48CBE306CE745F3EE7671458D6271B06C136B7274523D820C2195D81CD1A51ADADF70B1CCF70A64E3625146ED4BEF711D11C7EEE1B566AAD7E9FD0A85E7BD0BDF65A1A0FD458AF3F34555F2AB93978CC79129242314D34A820D7DEEE94455E47C45B8762750BB8000D92147406061FFB3F19E2DBF9D5885AF35311B7CDCF541D783CCEA4CB210AAF060E56234C98E181B090A488BAB7D6487AC614A9E19AB93E738253CC6438702BB0CFAE750A35B7AE77D002DD26A58C820604FA20A30806DD866CE7A047E3A21D68D6EC8A6CD4C9CC79B8320A814204A8A376A122149CCCE4305E0A4B988137A38A345C455D5D72C9768A45D35E103AD741AF8D68E3E06DF22A301BE44A911BC8CBB06D10176AD3481B6AD2B6AFAE3B8D1596DB900EC7EE50510BBA3EA201E8EEE0D0E050E958CFF0ED23F53E6EA934D7694DF06F82FF36676D01BEC1A094ADF741AB645BC37C5D3B09CAE2495564091C5596D1054A53C86D8DAA8B1AF1A665C965F26A3ABC1411973C82905B2A12B5B4F54E70BB420BACCDC2D655068717099A21792F9844B1B14C736A87CB549BB5FCD6B453E54AD572F97749E22C8E5802BBA23E8363C5322714F7471DD2265D51F342146596BBEA24A179CCDCB9C94D5DDE3E9BF4E588C9611468821B49C8509006555DDDBD8CA1DCE6B1C62863E6706338E8BEB6315C1C5A2FF626A3D6447F7EF595A3C9CB790F71F3D1AFF44D76FADC8B819E23DC0F039ECCB7C36167A5FADAA0FBD26668A7324B1850E9B987A7AB95566FB6E856E660DBB3B895CC4D7DF4B246C1C87E6B6FEC3A4820E74BA59740C0629838FA25C3349E71D7D097D4D0A9EF1CDADD62A4F2FCE6368F91F8CB25BE07B23F808E20E94F575CE078572ED89DFE4127940058D70B2E102373CC45F992F70FF6F60FB446D1CB69DA049C47B44FE7E6D92B6382B015916A7D44EF843DA02CBC479959F1EA643AB021F1ECAA29D4B2B12CF8FC7AEB55E18FE06FF10415FE1A1FC63BFA9C457839F6FF2CE88EBCF3DF3E29D21DEF2A03FF3CF2F6BCBF9EA839D00FA5834AE0DFE134546BF6B4DB4F75EEF469AEB566B6CD9AAEB768A8BB076815D9A340AB241EB6714134605B979DB6ABFEAA8AD0F002AD56E7D8A636B8558DD7F50EFF3265DD6FAA926BBDDA0E37D4BE719FBE6227905904F68EC3F2E634413C4491E90FF2D2D9B97B51AFD405D85CFB7D5443E0D9C0627F1C0E0982CF8C17DBCBA36131DD58163BFD8FB0D2D77ACF8914E7E3EEC971626FA29865D9EE2E85CA1DAE1649F9B6834BE94C86A132C3394AFED6F689BB7B62E36C2FD1DB3A2BAEC68A8DABB56E6F95D6CE783DE594D9BAC597EBEAB48CD6A8596FEC6D980D9127EDDCD46D97AE068EA39C335C5447FCB1959B9EF490556BA8F390F612911EAAB58AE3731C70405BCA2C0941B86A7C1F0C919293C59A85FC5A98E1B015A8EA35E76C9E54E15293A85AA2DDCD2FB040F01846C7992073140A980E313C31E5073AEA238BD37886A37376958B341770641CCF68EB831F1977BBF62F7A6F6D99475769F119CE531C01C424F23D7FC5DEE5A4F131C999E591E0602103BA7A764A5B0AF9FC5CAC6A4E9709EBC948A9AFCE43B7384E2930E3576C8A1EF036B2DD71FC012F50B8AA2A7B6E269B0DD156FBE884A0458662AE78ACE9E12760388A976FFE03F23C668C262F0000 , N'6.1.3-40302')
END
